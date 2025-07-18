import 'package:flutter/material.dart';
import 'package:pay_fusion/main.dart';

class CharityFormPage extends StatefulWidget {
  const CharityFormPage({super.key});
  @override
  _CharityFormPageState createState() => _CharityFormPageState();
}

class _CharityFormPageState extends State<CharityFormPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _charityNameController = TextEditingController();
  final TextEditingController _ngoNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  String? _certificateFileName;
  String? _taxExemptionFileName;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _charityNameController.dispose();
    _ngoNumberController.dispose();
    _addressController.dispose();
    _locationController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E13),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // Enhanced Header
              _buildHeader(),
              // Form Content
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F1115),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Progress indicator
                          _buildProgressIndicator(),
                          const SizedBox(height: 32),
                          // Scrollable form content
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSectionTitle(
                                    'Organization Details',
                                    Icons.business,
                                  ),
                                  const SizedBox(height: 20),
                                  _buildInputField(
                                    'Charity Name',
                                    _charityNameController,
                                    Icons.account_balance,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter charity name';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  _buildInputField(
                                    'NGO Registration Number',
                                    _ngoNumberController,
                                    Icons.confirmation_number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter NGO number';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  _buildInputField(
                                    'Mailing Address',
                                    _addressController,
                                    Icons.location_on,
                                    maxLines: 3,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter mailing address';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  _buildInputField(
                                    'Location/City',
                                    _locationController,
                                    Icons.place,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter location';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  _buildInputField(
                                    'Email Address',
                                    _emailController,
                                    Icons.email,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter email address';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 32),
                                  _buildSectionTitle(
                                    'Required Documents',
                                    Icons.folder_open,
                                  ),
                                  const SizedBox(height: 20),
                                  _buildFileUploadSection(
                                    'Certificate of Registration',
                                    _certificateFileName,
                                    Icons.file_present,
                                    onTap:
                                        () => _handleFileUpload('certificate'),
                                  ),
                                  const SizedBox(height: 20),
                                  _buildFileUploadSection(
                                    'LHDN Tax Exemption Approval Letter',
                                    _taxExemptionFileName,
                                    Icons.description,
                                    onTap:
                                        () =>
                                            _handleFileUpload('tax_exemption'),
                                  ),
                                  const SizedBox(height: 40),
                                ],
                              ),
                            ),
                          ),
                          // Enhanced submit button
                          _buildEnhancedSubmitButton(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              const Spacer(),
              const Text(
                'Charity Application',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4ECDC4).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.volunteer_activism,
                  color: Color(0xFF4ECDC4),
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Join our platform to make a positive impact in your community',
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProgressDot(true),
            _buildProgressLine(true),
            _buildProgressDot(false),
            _buildProgressLine(false),
            _buildProgressDot(false),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Step 1 of 3 - Organization Information',
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildProgressDot(bool isActive) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF4ECDC4) : Colors.grey.shade600,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildProgressLine(bool isActive) {
    return Container(
      width: 40,
      height: 2,
      color: isActive ? const Color(0xFF4ECDC4) : Colors.grey.shade600,
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF4ECDC4).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF4ECDC4), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    IconData icon, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
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
            color: const Color(0xFF1A1D23),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade800, width: 1),
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            validator: validator,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: const Color(0xFF4ECDC4), size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              hintText: 'Enter $label',
              hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileUploadSection(
    String title,
    String? fileName,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    bool hasFile = fileName != null;

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
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  hasFile
                      ? const Color(0xFF4ECDC4).withOpacity(0.1)
                      : const Color(0xFF1A1D23),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasFile ? const Color(0xFF4ECDC4) : Colors.grey.shade800,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color:
                        hasFile
                            ? const Color(0xFF4ECDC4)
                            : Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    hasFile ? Icons.check : icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hasFile ? fileName : 'Tap to upload file',
                        style: TextStyle(
                          color:
                              hasFile ? const Color(0xFF4ECDC4) : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (!hasFile)
                        Text(
                          'PDF, JPG, PNG (Max 5MB)',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                Icon(
                  hasFile ? Icons.edit : Icons.upload,
                  color:
                      hasFile ? const Color(0xFF4ECDC4) : Colors.grey.shade500,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedSubmitButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4ECDC4), Color(0xFF44B5A0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4ECDC4).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextButton(
        onPressed: _isSubmitting ? null : _handleSubmit,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child:
            _isSubmitting
                ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'SUBMIT APPLICATION',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  void _handleFileUpload(String type) {
    // Simulate file upload
    setState(() {
      if (type == 'certificate') {
        _certificateFileName = 'certificate_registration.pdf';
      } else {
        _taxExemptionFileName = 'tax_exemption_letter.pdf';
      }
    });

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: const Text('File uploaded successfully!'),
    //     backgroundColor: const Color(0xFF4ECDC4),
    //     behavior: SnackBarBehavior.floating,
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    //   ),
    // );
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isSubmitting = false;
      });

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: const Row(
      //       children: [
      //         Icon(Icons.check_circle, color: Colors.white),
      //         SizedBox(width: 12),
      //         Text('Application submitted successfully!'),
      //       ],
      //     ),
      //     backgroundColor: const Color(0xFF4ECDC4),
      //     behavior: SnackBarBehavior.floating,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(12),
      //     ),
      //   ),
      // );

      hasIsiCharity = true;
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
