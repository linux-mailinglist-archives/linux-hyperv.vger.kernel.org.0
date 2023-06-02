Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCE0720789
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jun 2023 18:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbjFBQ1d (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Jun 2023 12:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbjFBQ1c (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Jun 2023 12:27:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5581AB;
        Fri,  2 Jun 2023 09:27:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=athI5JJ+X6fj3N3jmLg1EtnCmb9rHNajyaYlDWc+Pr7bfvozkbFVKCQ5gdLpPxYIGrE5B2fr2IJUG1h1wJpYRQQ6kq76XT+JQeOVmfy+iohDCJ4dkjppmX9GLcNfx/Zio/pTUdsiTOcpao6928h4NFD9L6KmQp19JNF3ilerURLKjxjUunGD2JzYcPmUdEWvKX66ZEE9sb8ZuOK1NEx+nN94dTV42TawmyQzNG8AJ1OjA0RL0Ow35GhUi2mdsbjj9cEx9zW23BeKF/ulL31CVodkIMmoPbPC8ipRPhEhoy3fAeX+IPuHcn9rFYQc5ZF4Sq3XcH8IX2NRzoDh0jON2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIIKYRrAKZyvl4eq/Q29C5A9O0xK+qTUS2n3oc/Xo/0=;
 b=m0VW4JGKN6FhtFHSUxDBSkzEEAUg/ij7pQGcuGVC3Zt/KV6AocPyR9Sr7sxJh8FXllrH1+gGlQzzoBlsGYQUpWKVIuP+LbkRo2sAp6dMGxC4Xjq52pX6CM5OI6NmaeCGphFQGEeCuPtRCoa9y6YewNHxJzFI4c5i6YTb/lgJi6jexwlAykZ5pSLX2nOSjgAErjFvl5a1CSnYe372XRV2vztmUxtCTExv0nqzXKlfMsSwof0sLNsxqFMiMUqa/dn/SrGnWNbDy0h319u1FgERsa+tioxyQ1lJYjNDQsuDUfk+xg0cFC1nNcUeUfZSP3Eb4VZ5H8eHRksnZVoGqlMD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIIKYRrAKZyvl4eq/Q29C5A9O0xK+qTUS2n3oc/Xo/0=;
 b=OntN79rVR+t4z9JtQKhj7YwH1B3JworzPqBMFesH6pEMSQEQd695kbf//jpyhzTS7o0iU2UKqXu8lc8aaPS3et1M56xZuEIb64X22cHMqq1BZa2TX5uHhQxwIY4CV5mgU6UmLue7nI8/aJYXwJjvUcgJ+pfsfQbHarsP54Luu+g=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 SI2P153MB0703.APCP153.PROD.OUTLOOK.COM (2603:1096:4:19e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.12; Fri, 2 Jun 2023 16:27:27 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6477.012; Fri, 2 Jun 2023
 16:27:26 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [EXTERNAL] Re: [PATCH] x86/hyperv: add noop functions to x86_init
 mpparse functions
Thread-Topic: [EXTERNAL] Re: [PATCH] x86/hyperv: add noop functions to
 x86_init mpparse functions
Thread-Index: AQHZlW584J74wZLF+kuxJEQRlX5gPa93syvQ
Date:   Fri, 2 Jun 2023 16:27:25 +0000
Message-ID: <PUZP153MB0749D15A769E61181593C6FABE4EA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1685709712-13752-1-git-send-email-ssengar@linux.microsoft.com>
 <ZHoXVAvof+STaIxI@liuwe-devbox-debian-v2>
In-Reply-To: <ZHoXVAvof+STaIxI@liuwe-devbox-debian-v2>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=efe20317-45fa-4cf6-92e8-774a3fa0f607;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-02T16:26:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|SI2P153MB0703:EE_
x-ms-office365-filtering-correlation-id: f885ebae-30d9-4c0b-419e-08db6386406c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A/QebfTpbcs0JN1Iu7o/cLdS7TmizZ7kyPWkpPjwPp6oJdF81SczsnVs86bmnVo5DlAI9kwBSbAEA+seIbxgzJxRMqK03I8GjKXrJyH9BBVvrRPE4Ma1u655CFt0ysej1oswbCDlK8vNAiMRBpJP2wpxJjXOF+YmRJKp28kJfUsGzgSp18G8aiLCpoO5abT2DI7+G2fZiExl3X+96cThNE2EzQydTzgs6VTtke0vvWF/5YsKpdWPJp/zfZdYyDU5+UE+pkcME7uCwd2FcZ362NWgd6sDI+UiPYrFhwfZzDmfcDTPMlvmFaTakaF3jpUCv123v4M3AZPMPv0NKoJxsIs8zNiOnV+K+QJYoyNNGfOruYoRHB5+V43OyQC6zFk02UCY7m3eVfJ52jv4hNwJeyhZwmzNIgqz56dzGbfPbjZKbxHT2f2nMHwOiOhmiSewgfWDkfmckor1bMd61QbcY4GWlIl9HZcuhNEZ8CCHMkuhwRgD8mFnAVZhUbBUE5/xstVcXBbi/DKHjHLPvxUzYuU+dCsSHI39LVxvA6twzh66vBjfkuFY3fsN6f0GAzF2KA7T1zopx6xlN/uZrb+OmP7bv3RbF1rQD2/yZhsKdZyPYxG+PGr68R/1mdh/BVdt24B/rKXjycSGQGMHkGepwf8vCjAEU13oelKYuuVQksc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(33656002)(478600001)(10290500003)(9686003)(186003)(53546011)(6506007)(7696005)(55016003)(83380400001)(71200400001)(41300700001)(38100700002)(64756008)(82950400001)(82960400001)(122000001)(66446008)(4326008)(66556008)(66476007)(66946007)(316002)(786003)(86362001)(2906002)(52536014)(5660300002)(38070700005)(76116006)(8936002)(8676002)(54906003)(110136005)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Cg3UeBDm3BVQUXiWPzzpoiSLPyU9+cXN591d8E/Zl865fnMqvkkfrLmPgmQ?=
 =?us-ascii?Q?umDvrNDP53iYFFvHdpqO7EBt5KfIHznnb87XSdwGscgANZ+JSyNRILSCXsr9?=
 =?us-ascii?Q?DqSaqnf8wPP2w1OcpexG5fmo3hv2ujLVryN6/9MnWuh8URc9tpwSbRwXjOn3?=
 =?us-ascii?Q?MaH0oFza5ACkmyxOJyZcdsU21clui7iY6RZHIgkRdpGyfSOg1nugf/MZj7g6?=
 =?us-ascii?Q?WTbqnQu5ybXsYlP539i5t2+gr8W0p8WwLRn7hSglQd5QkHIaIJ1rXaoZnEwD?=
 =?us-ascii?Q?wW0MDQ8d/QEEdvw8zmjI789sjZ1ncmLtdw/p2xvmnKKAztSQ91yEq6EA6eeF?=
 =?us-ascii?Q?Ck9pVhz6SEMRJsGPOMw7zid4lMUExSXclB6J/c+VVFT++Groe7YwudF70r5T?=
 =?us-ascii?Q?UTFyGfGLyfMIoZzry4lbYk2v1CoaNfjgk3QlGSaoW9eEZkAPE6nYVOj3Iad7?=
 =?us-ascii?Q?RLsg4J/QSTQBcBQv5gOIxKg6Vg6hCU2RAV0sobmRXsMjC3GBn31WK60e/5CZ?=
 =?us-ascii?Q?zJ8Ugrt/K7qQ490OmCpNwCxgDVk7zuubSwIEqLunawnHych9KKko0nFi0NLh?=
 =?us-ascii?Q?dbl+XMLEr1CE9m9Ol5gOoUKEq6cI6GZCd2qGHyQ/XsuyMpn0P9xcgnkjFdO9?=
 =?us-ascii?Q?5mYbjUoPENXBTG4QjQY+Fd0nNxuJdQH66alxFDZFAt4ogLREjtRQEw7SbwxT?=
 =?us-ascii?Q?m7DNUJRuAwPEZ2VZWt5EiGBSkh5zPK4o0de7C6KvoxIXR0UIwAvExYGDCKYJ?=
 =?us-ascii?Q?7bbzVupyTjyMaE20UFlxpKAJg2j6D+j86GoCERRe1h8brN1SHetp+sYnaw7k?=
 =?us-ascii?Q?Ayg4cu9AomMdsAMcscnKzKYfkXzzx/buwaes1bSCTOFCIiUw2N072nVLvLJO?=
 =?us-ascii?Q?tELJ9lOHsFPRVZXmxXXY5amQDnRmjPgMoe2mdRWU+hDOF6ZwPsYP1qfqe9LS?=
 =?us-ascii?Q?dcGW7z9sZCedr04Vl6m0tSAKDOMEHbnWR7cAOFoP9D9KzEA2Q1WEMYAoyxUK?=
 =?us-ascii?Q?oF7RS5odHwHordUpTEhorSaiNbVu0g3UhMi4gjxbE7gGbpe0sX8PSZmhXYV7?=
 =?us-ascii?Q?sst+lLlcE5yrUEk5YwUCqyeidODNtLMGEZawhcZDovwAsNDfTLTKUVMpDmRS?=
 =?us-ascii?Q?WkO7Y8XCMQuy1MuErYDYT+a1xBpZbaiWoKh0gAJBK0zgF72S4SlCL8Z8wNr7?=
 =?us-ascii?Q?VjgIkdioTljIPAbjd83+mHfSdWhR3vTBmWkJjU+zFjTw6qebUgTQ8pX0eiv6?=
 =?us-ascii?Q?dZp80JfEPxV7X3+goS7T9RrOkjJa1/SluNaHjmS06EEFWzzuZDzc4edmA1XJ?=
 =?us-ascii?Q?flDl9dlE6bA+uKfUEvRZ/yGsAtBy8St/Lzqs4UpOI6njeDtTHOVv8GzcbGT5?=
 =?us-ascii?Q?cyB404eAORkuTflrs0xiFbznjJKQaoCNtmwAsfNWIWK1q24OPy5YmP8F0F09?=
 =?us-ascii?Q?1TmsZs7r2HhjepwtymY3gOTiWAYRG4HIAXM6rQw4BSGKA4XuVvi9vfQQkWVt?=
 =?us-ascii?Q?vWyvyMknYmeb4Gmg3TaVkFwLCQvQHl2725ryRLSQqJTaT+j22lQ34dpPowLD?=
 =?us-ascii?Q?Om497KfEC15woksiGc5wOKNGhNgr3n4umzYWFhzZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f885ebae-30d9-4c0b-419e-08db6386406c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 16:27:26.0119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzCyQff1g6zraMvhaTrN489681ooJHrA9nc4DqrFKXPLk+Mpc9pEA4rniJ5c2k6YhMt7T8k7i3fbE0bLHMKZ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0703
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Wei Liu <wei.liu@kernel.org>
> Sent: Friday, June 2, 2023 9:53 PM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; tglx@linutronix.de; mingo@redhat.com;
> bp@alien8.de; dave.hansen@linux.intel.com; x86@kernel.org; Michael Kelley
> (LINUX) <mikelley@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> hyperv@vger.kernel.org; hpa@zytor.com
> Subject: [EXTERNAL] Re: [PATCH] x86/hyperv: add noop functions to x86_ini=
t
> mpparse functions
>=20
> On Fri, Jun 02, 2023 at 05:41:52AM -0700, Saurabh Sengar wrote:
> > In !ACPI system, there is no way to disable CONFIG_X86_MPPARSE.
> > When CONFIG_X86_MPPARSE is enabled for VTL2, the kernel will scan low
> > memory looking for MP tables. Don't allow this, because low memory is
> > controlled by VTL0 and may contain actual valid tables for VTL0, which
> > can confuse the VTL2 kernel.
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_vtl.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c index
> > 1ba5d3b99b16..ea21d897b5da 100644
> > --- a/arch/x86/hyperv/hv_vtl.c
> > +++ b/arch/x86/hyperv/hv_vtl.c
> > @@ -23,6 +23,10 @@ void __init hv_vtl_init_platform(void)
> >  	x86_init.irqs.pre_vector_init =3D x86_init_noop;
> >  	x86_init.timers.timer_init =3D x86_init_noop;
> >
> > +	/* Avoid searching for BIOS MP tables */
> > +	x86_init.mpparse.find_smp_config =3D x86_init_noop;
> > +	x86_init.mpparse.get_smp_config =3D x86_init_uint_noop;
> > +
>=20
> The code looks fine.
>=20
> Can you expand the commit message a bit so that people who are not
> familiar with VTL and your setup can understand what's going on?

Sure, I will add more details in commit message.

>=20
> Thanks,
> Wei.
>=20
> >  	x86_platform.get_wallclock =3D get_rtc_noop;
> >  	x86_platform.set_wallclock =3D set_rtc_noop;
> >  	x86_platform.get_nmi_reason =3D hv_get_nmi_reason;
> > --
> > 2.34.1
> >
