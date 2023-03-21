import 'package:companion_rebuild/features/components/custom_appbar.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(title: 'Privacy Policy'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(size.width*0.05, size.width*0.05, size.width*0.05, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
            Text('Privacy Policy of Companion'),
            SizedBox(height: 10),
            Text('Companion operates the companion.lightheads.org website, which provides the SERVICE.'),
            SizedBox(height: 10),
            Text('This page is used to inform website visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service, the companion.lightheads.org website.'),
            SizedBox(height: 10),
            Text('If you choose to use our Service, then you agree to the collection and use of information in relation with this policy. The Personal Information that we collect are used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.'),
            SizedBox(height: 10),
            Text('The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at companion.lightheads.org, unless otherwise defined in this Privacy Policy.'),
            SizedBox(height: 20),
            Text('Information Collection and Use'),
            SizedBox(height: 10),
            Text('For a better experience while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to your name, phone number, and postal address. The information that we collect will be used to contact or identify you.'),
            SizedBox(height: 20),
            Text('Log Data'),
            Text('We want to inform you that whenever you visit our Service, we collect information that your browser sends to us that is called Log Data. This Log Data may include information such as your computer’s Internet Protocol (“IP”) address, browser version, pages of our Service that you visit, the time and date of your visit, the time spent on those pages, and other statistics.'),
            SizedBox(height: 20),
            Text('Cookies'),
            SizedBox(height: 10),
            Text('Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your computer’s hard drive.'),
            SizedBox(height: 10),
            Text('Our website uses these “cookies” to collection information and to improve our Service. You have the option to either accept or refuse these cookies, and know when a cookie is being sent to your computer. If you choose to refuse our cookies, you may not be able to use some portions of our Service.'),
            SizedBox(height: 20),
            Text('Service Providers'),
            Text('We may employ third-party companies and individuals due to the following reasons:'),
            Text('To facilitate our Service;'),
            Text('To provide the Service on our behalf;'),
            Text('To perform Service-related services; or'),
            Text('To assist us in analyzing how our Service is used.'),
            Text('We want to inform our Service users that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.'),
            SizedBox(height: 20),
            Text('Security'),
            Text('We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.'),
            SizedBox(height: 20),
            Text('Links to Other Sites'),
            Text('Our Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over, and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.'),
            SizedBox(height: 20),
            Text('Children’s Privacy'),
            Text('These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions.'),
            Text('Changes to This Privacy Policy'),
            Text('We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately, after they are posted on this page.'),
            SizedBox(height: 20),
            Text('Contact Us'),
            Text('If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us.'),
          ],),
        ),
      )
    );
  }
}
