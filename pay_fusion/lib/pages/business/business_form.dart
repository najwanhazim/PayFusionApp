import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_fusion/pages/charity/charity_form.dart';
import 'package:pay_fusion/pages/charity/charity_list.dart';

class BusinessFormPage extends StatefulWidget {
  const BusinessFormPage({super.key});
  @override
  _BusinessFormPageState createState() => _BusinessFormPageState();
}

class _BusinessFormPageState extends State<BusinessFormPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _tinNumberController = TextEditingController();
  final TextEditingController _brnNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _businessTypeController = TextEditingController();

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _isSubmitting = false;

  final List<String> _uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _businessNameController.dispose();
    _tinNumberController.dispose();
    _brnNumberController.dispose();
    _locationController.dispose();
    _businessTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1115),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Business Registration',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF0F1115),
                  const Color(0xFF1A1D23),
                  const Color(0xFF0F1115),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _buildProgressIndicator(),
                    const SizedBox(height: 30),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader('Business Information'),
                            const SizedBox(height: 20),
                            _buildInputField(
                              'Business Name',
                              _businessNameController,
                              Icons.business,
                              'Enter your business name',
                            ),
                            const SizedBox(height: 20),
                            _buildInputField(
                              'TIN Number (T)',
                              _tinNumberController,
                              Icons.numbers,
                              'Enter TIN number',
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 20),
                            _buildInputField(
                              'BRN Number',
                              _brnNumberController,
                              Icons.confirmation_number,
                              'Enter BRN number',
                            ),
                            const SizedBox(height: 20),
                            _buildInputField(
                              'Location',
                              _locationController,
                              Icons.location_on,
                              'Enter business location',
                            ),
                            const SizedBox(height: 20),
                            _buildInputField(
                              'Business Type',
                              _businessTypeController,
                              Icons.category,
                              'Enter business type',
                            ),
                            const SizedBox(height: 40),
                            _buildSectionHeader('Required Documents'),
                            const SizedBox(height: 20),
                            _buildFileUploadSection(
                              'Upload SSM Forms (9, 24, 49)',
                              'SSM_Forms',
                              Icons.description,
                            ),
                            const SizedBox(height: 20),
                            _buildFileUploadSection(
                              'Upload Founder Identification',
                              'Founder_ID',
                              Icons.person,
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                    _buildSubmitButton('SUBMIT APPLICATION'),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Color(0xFF4ECDC4), size: 20),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Step 1 of 3: Business Information',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF4ECDC4).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '33%',
              style: TextStyle(
                color: Color(0xFF4ECDC4),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF4ECDC4), width: 2)),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    IconData icon,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
              prefixIcon: Icon(icon, color: const Color(0xFF4ECDC4), size: 20),
              errorStyle: TextStyle(color: Colors.red),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFileUploadSection(String title, String fileKey, IconData icon) {
    bool isUploaded = _uploadedFiles.contains(fileKey);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _handleFileUpload(fileKey),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 60,
            decoration: BoxDecoration(
              color:
                  isUploaded
                      ? const Color(0xFF4ECDC4).withOpacity(0.1)
                      : const Color(0xFF2A2D35),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    isUploaded
                        ? const Color(0xFF4ECDC4)
                        : Colors.white.withOpacity(0.2),
                width: isUploaded ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Icon(
                  isUploaded ? Icons.check_circle : icon,
                  color: isUploaded ? const Color(0xFF4ECDC4) : Colors.white70,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    isUploaded
                        ? 'File uploaded successfully'
                        : 'Tap to upload file',
                    style: TextStyle(
                      color:
                          isUploaded ? const Color(0xFF4ECDC4) : Colors.white70,
                      fontSize: 14,
                      fontWeight:
                          isUploaded ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
                Icon(
                  isUploaded ? Icons.done : Icons.upload,
                  color: isUploaded ? const Color(0xFF4ECDC4) : Colors.white70,
                  size: 20,
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(String text) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4ECDC4), Color(0xFF44B3AC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4ECDC4).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _isSubmitting ? null : _handleSubmit,
          child: Center(
            child:
                _isSubmitting
                    ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.send, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }

  void _handleFileUpload(String fileKey) {
    HapticFeedback.lightImpact();

    // Simulate file upload
    setState(() {
      if (_uploadedFiles.contains(fileKey)) {
        _uploadedFiles.remove(fileKey);
      } else {
        _uploadedFiles.add(fileKey);
      }
    });

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(
    //       _uploadedFiles.contains(fileKey)
    //           ? 'File uploaded successfully'
    //           : 'File removed',
    //     ),
    //     backgroundColor:
    //         _uploadedFiles.contains(fileKey)
    //             ? const Color(0xFF4ECDC4)
    //             : Colors.orange,
    //     behavior: SnackBarBehavior.floating,
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    //   ),
    // );
  }

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_uploadedFiles.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload all required documents'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isSubmitting = false);

    // Show success dialog
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1A1D23),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Color(0xFF4ECDC4), size: 28),
                SizedBox(width: 12),
                Text(
                  'Success!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            content: const Text(
              'Your business application has been submitted successfully. We will review your application and get back to you within 3-5 business days.',
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharityListPage(),
                      ),
                    ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Color(0xFF4ECDC4),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
