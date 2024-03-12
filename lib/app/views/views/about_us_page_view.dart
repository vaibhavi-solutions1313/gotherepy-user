import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../appWidgets/universalAppBar.dart';

class AboutUsPageView extends GetView {
  const AboutUsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'About Us',appBar: AppBar(),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text( 'Lorem ipsum dolor sit amet consectetur. In nulla massa duis natoque integer id enim. Fusce elementum pretium donec turpis. Justo porta non est maecenas. Nulla penatibus ultrices sit nunc in enim enim.'
            'Pellentesque egestas enim risus diam urna purus scelerisque turpis. Interdum sodales orci odio dui lectus tortor in. Nulla diam netus vestibulum ullamcorper ipsum turpis. Non amet interdum orci mattis tortor. Et aliquet elit nunc cursus diam quis sapien et.'
            'Purus fames id elementum nec natoque nulla at tristique. Et nam nibh odio nunc egestas'
              'Lorem ipsum dolor sit amet consectetur. In nulla massa duis natoque integer id enim. Fusce elementum pretium donec turpis. Justo porta non est maecenas. Nulla penatibus ultrices sit nunc in enim enim.'
              'Pellentesque e'
              'gestas enim risus diam urna purus scelerisque turpis. Interdum sodales orci odio dui lectus tortor in. Nulla diam netus vestibulum ullamcorper ipsum turpis. Non amet interdum orci mattis tortor. Et aliquet elit nunc cursus diam quis sapien et.'
              'Purus fames id elementum nec natoque nulla at tristique. Et nam nibh odio nunc egestas'
              'Lorem ipsum dolor sit amet consectetur. In nulla massa duis natoque integer id enim. Fusce elementum pretium donec turpis. Justo porta non est maecenas. Nulla penatibus ultrices sit nunc in enim enim.'
              'Pellentesque egestas enim risus diam urna purus scelerisque turpis. Interdum sodales orci odio dui lectus tortor in. Nulla diam netus vestibulum ullamcorper ipsum turpis. Non amet interdum orci mattis tortor. Et aliquet elit nunc cursus diam quis sapien et.'
              'Purus fames id elementum nec natoque nulla at tristique. Et nam nibh odio nunc egestas'
              " dapibus nunc non. Mattis nulla malesuada ac nec aliquam velit. Nisl risus quam suspendisse ornare lectus ornare vitae nunc consequat. Eget arcu rhoncus porta neque eget pellentesque tincidunt dui eu."
              'Diam gravida purus viverra bibendum. Proin fusce etiam dictumst leo. Vel nibh varius tincidunt nunc integer viverra eget pretium. Pulvinar vivamus quam lectus sit integer sit sed sit fames. Odio pulvinar habitant suspendisse molestie. Lacinia rhoncus ultricies amet bibendum. Egestas ac massa orci et purus.'
              " dapibus nunc non. Mattis nulla malesuada ac nec aliquam velit. Nisl risus quam suspendisse ornare lectus ornare vitae nunc consequat. Eget arcu rhoncus porta neque eget pellentesque tincidunt dui eu."
              'Diam gravida purus viverra bibendum. Proin fusce etiam dictumst leo. Vel nibh varius tincidunt nunc integer viverra eget pretium. Pulvinar vivamus quam lectus sit integer sit sed sit fames. Odio pulvinar habitant suspendisse molestie. Lacinia rhoncus ultricies amet bibendum. Egestas ac massa orci et purus.'
            " dapibus nunc non. Mattis nulla malesuada ac nec aliquam velit. Nisl risus quam suspendisse ornare lectus ornare vitae nunc consequat. Eget arcu rhoncus porta neque eget pellentesque tincidunt dui eu."
              'Lorem ipsum dolor sit amet consectetur. In nulla massa duis natoque integer id enim. Fusce elementum pretium donec turpis. Justo porta non est maecenas. Nulla penatibus ultrices sit nunc in enim enim.'
              'Pellentesque egestas enim risus diam urna purus scelerisque turpis. Interdum sodales orci odio dui lectus tortor in. Nulla diam netus vestibulum ullamcorper ipsum turpis. Non amet interdum orci mattis tortor. Et aliquet elit nunc cursus diam quis sapien et.'
              'Purus fames id elementum nec natoque nulla at tristique. Et nam nibh odio nunc egestas'
              " dapibus nunc non. Mattis nulla malesuada ac nec aliquam velit. Nisl risus quam suspendisse ornare lectus ornare vitae nunc consequat. Eget arcu rhoncus porta neque eget pellentesque tincidunt dui eu."
              'Diam gravida purus viverra bibendum. Proin fusce etiam dictumst leo. Vel nibh varius tincidunt nunc integer viverra eget pretium. Pulvinar vivamus quam lectus sit integer sit sed sit fames. Odio pulvinar habitant suspendisse molestie. Lacinia rhoncus ultricies amet bibendum. Egestas ac massa orci et purus.'
            'Diam gravida purus viverra bibendum. Proin fusce etiam dictumst leo. Vel nibh varius tincidunt nunc integer viverra eget pretium. Pulvinar vivamus quam lectus sit integer sit sed sit fames. Odio pulvinar habitant suspendisse molestie. Lacinia rhoncus ultricies amet bibendum. Egestas ac massa orci et purus.',
          style:TextStyle(fontSize: 13),softWrap: true,textAlign: TextAlign.justify,),

        ),
      ),
    );
  }
}
