Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041B86E183B
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Apr 2023 01:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjDMXUm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Apr 2023 19:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjDMXUf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Apr 2023 19:20:35 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020026.outbound.protection.outlook.com [52.101.56.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008A265AE;
        Thu, 13 Apr 2023 16:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2TI/RqWzYME0mOi78vpuUEqcRGrb64DLfLcH6ULRbch2GmvkbQUwjSdvZQLCtuf6XN/+CmwFKn6z7YX8JEubteOFRWC/HpXALp0FBWyCymkIlq3Nb/qhxjRydiIn15iIsvcLWwB4Ci6qYgqcrLFX1mDZ8SvV3lIuMGFgATh1mT0w1uSQgLKgH83XJYKgIvMKfWHENZZGbUcXawyuF7epZSxjvxicB5nm/E4H4cWgKWGR3rnrVeEFrdL4Xi8gd4AXFGOu2ge9z8uuqzvyag+yM067eO0l9N1+1QODHINAv4TRyLKIfISkUapPwMJB02neA3hgMpc+T1gM+IrLRhyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKt1H9lt1ICW9A2MPvXOig5tIZkvjGlH8Vkdo6XiELw=;
 b=JpQNROMYaguIgA8jfh62s0Xy9ra7M3CytxXi6yTj+D+vPtCaZplnSzpbdCYKPcj9yUXpQL2d/1ddNgy7TFS72uwy6n6TslNQ0oSOsYM8Fqrz7UUsRG6NxocGrm5qwvijWObnDhYRzItFujCmxB4l+PUQX791otBXEWVFFtXCcRgTJF6cUOa5l0Q+5tnOBZQDQRihJW9RT8jPWJ7S15yhYOftTEYJZnUUpRbiJ8eAy1+QRMBTsZj+0DaSyUxlKDTx5nU7Qx/WKFKETolFn3D822jqXau/9GrXhdjRgFcD87KRatZOYb4AS2xkEYGQt0VOp3kXLaXaZETkJhBqBUxO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKt1H9lt1ICW9A2MPvXOig5tIZkvjGlH8Vkdo6XiELw=;
 b=fNJ6zw/qDY2RgNn95xZyHFMSvEGIeJIOCz0BfqktqsOH5EPutysuREs4jO7BJ/T0NKXHlaZR1s9+qovEa7tdgZFoXTKijp7ZVlAr7yNBOmUBDm988+PlWbOWigVmAQZSDKRMO23bIdnJhFBd5r3kxdZVVBKyirEiwVKKD/zuVro=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by IA1PR21MB3547.namprd21.prod.outlook.com (2603:10b6:208:3e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.4; Thu, 13 Apr
 2023 23:19:57 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.006; Thu, 13 Apr 2023
 23:19:57 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     Dave Hansen <dave.hansen@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>
Subject: RE: [PATCH 1/1] x86/irq: Add hardcoded hypervisor interrupts to
 /proc/stat
Thread-Topic: [PATCH 1/1] x86/irq: Add hardcoded hypervisor interrupts to
 /proc/stat
Thread-Index: AQHZStvOKEpex/oSu0efNAklHfBImK8HPJyAgAAZNICAAGGUAIABDrgggCFf42A=
Date:   Thu, 13 Apr 2023 23:19:56 +0000
Message-ID: <BYAPR21MB1688027848D4BAE9A39FC613D7989@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1677523568-50263-1-git-send-email-mikelley@microsoft.com>
 <dce372bd-e63c-f24c-5b79-1ef65fd1e59a@intel.com>
 <BYAPR21MB16884B3D0E15E501A7BB8E78D7869@BYAPR21MB1688.namprd21.prod.outlook.com>
 <ZBuq4KjU2ekKk+iS@google.com>
 <BYAPR21MB1688CF3ABAF181A17443BF3FD7879@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688CF3ABAF181A17443BF3FD7879@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e488351e-066c-48af-9936-c8c394f6f831;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-23T17:35:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|IA1PR21MB3547:EE_
x-ms-office365-filtering-correlation-id: 1748fb77-5e3e-43a2-e65a-08db3c759875
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSRjoB6QYAmRs06eV+I9gntR3Xt1ucLv5u7pU7gOjI4f0hU4tz5OzIEyqVkL8lII19gx5PAS7NWHRvfqT1TSEue5LJTCeZzHnPL7dfjPBZVMkzP+ZSytTsCQxeN7n42isUqJ6wdezWgppIjqc8F9fQ1MRLxqs+/4MCaIsTfOXpmQzR3tpeODfkL8NGJtlg4w38Fx8fKotkvMHr3W6iMZyzZAfEqXnU36a97r7E8hgFuu4wJFXggTAqi2HDaZVZCvqWLjCXFete7EtK+plfTKD1i2lyPowO46pjzbPs+sdyH7p1J2s2G1m28XboZDbGEa+26BblhqQwS5AMc7Z/1pGK80Uio6j7aUeO7TzJPd56c08t6BC+Au9TioFEuM/mr59dNb4BWvhbu8/raFdGlzkx9U+zyqIr5qylMGiF2wqAKKzdECQXCdjAZHc9r4HkuVihpnzSas9dW0l5ZJwECFuqS9lrdcmC9qjJXBKv3yTcKjJSaVii1m3OzsEvkKF+UUbNPplAWFwBraEm52nxm/geJdmLJHZC6By882vhODh8++f/g+92DHN95XdHBoIq3LXfeOUD8lFVnzpEPq4eytxj+XX0BGrbEysqi9LaK9ed+RlLxdWmozfwXs6E3ECodl8z6V8QnHlWDG2WxBlxnfwNhrKidDp89FtjONxBgAcKo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(10290500003)(54906003)(786003)(122000001)(55016003)(66946007)(76116006)(7416002)(52536014)(38070700005)(82950400001)(5660300002)(8676002)(8936002)(86362001)(82960400001)(316002)(38100700002)(4326008)(110136005)(33656002)(478600001)(66476007)(66556008)(64756008)(66446008)(8990500004)(2906002)(53546011)(9686003)(6506007)(26005)(186003)(7696005)(71200400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MPWKQ7GOZBqCDySbwAVHgaT73jpRvaNMRh8CNwCW23gSVwVuUMk+4ezYN0hr?=
 =?us-ascii?Q?3Ho7QROPpUunF/Fz7KEe8F7jrPTCVW1kDllO9YZFTkGcgp9r6I3msCvAtNMZ?=
 =?us-ascii?Q?T7yFnZyQDe7321aBY7dykM2XrR1+sxpuTQfEWW1Di24Kq3XlMFza8JmKk/td?=
 =?us-ascii?Q?TfaybjRpS1lSV/L+nmnZx3kFPB5byq2b7o+LFu+s+tHHoAed+6zdaYqIVCou?=
 =?us-ascii?Q?dInez9dDUlKrQsbHozmufGuDMrWRL4SivULcCY7b8vXTVL5J3KR9qorkqr2r?=
 =?us-ascii?Q?TV7Oq2i9ydCLilMZ4QAZ6alOYCJqExZTrlTX6saSzUT5f4kDY5RpZ7XLAsWG?=
 =?us-ascii?Q?b79a+sN62JVEncmlaMj6X56uK9MeB3Ck+VeVg2aPAvDzp7pePpPaxj0kDMhx?=
 =?us-ascii?Q?oo1B40cfXnJYJRE8wDlI0uxrZ1Za2znWqoZ0eSwBp2WHyU+vv7bvpo+IDJ5h?=
 =?us-ascii?Q?FkCAWvh4GQE41tMRY3Yp6zxJeA34qGozsWXQ59xugQEEuhOVZAnEMmlhy+Zf?=
 =?us-ascii?Q?CaaShPXCspNztxHlFc9ROk+LVV+XF50NgATDxxtRgxdkoftxXDkXCwhiyA6I?=
 =?us-ascii?Q?/Lb3J+XP0PVDACXQP3xlAUYGDrSOBwccCkx6cNMto0mQHkQTwZpnLK7YZjR8?=
 =?us-ascii?Q?hat78pgGOaGhU+JEG+bJvBDztB/b36fTwhKzM68Swz0fPpSLblpPxWitTNpW?=
 =?us-ascii?Q?/oR8SQ4Hp5tYjryCH9OO71VsOb0iBWf5q/q8akN9lRGCv99hiUnS878lK9Gz?=
 =?us-ascii?Q?KAhKXFSGUsbO1lbNSk7OSx0pY6qVaEM5FwGIaeysa5LRUmkU1QdALSfo8QXs?=
 =?us-ascii?Q?/Woi9aiCkbeosKfXhgJAJfDPpKvPrhq8Neurv5CDwYxF001N3+zEs8cwbiZV?=
 =?us-ascii?Q?aLRugIlvZN55r7er/18A2eZEHF1onJ2ouePwLWjPWJS7WZ3ldgk2SvC1tnm1?=
 =?us-ascii?Q?WTSXRSUT2PGqvsKNy9mSJuFBAjdfmCZT52qs1u71nGerCVT+To5tnIjYtylX?=
 =?us-ascii?Q?cDOxfioM/dPC3MkD+CqiFfK8D91LUzH3BBP3JefS5/718r1sZSfu+fgWtBfr?=
 =?us-ascii?Q?RkNY13ljCO9cfD17Q++c8NlVVoqrSt6MP5smOFuzy6Z389xOuttF6/WeEoXp?=
 =?us-ascii?Q?MVE7BOqnELzynkzYP/IKJ9MzkeMaICx9lIZjTfoEEnK6zthskpler0UCVIyh?=
 =?us-ascii?Q?XlEOjpdM+mcUtF3K0FnWmNmq3S34riavQYw34BicHZ1vOlUdJ1Mo0ejEFqK1?=
 =?us-ascii?Q?KtMRbuJdl70h9SlU4N2X+FAGgcZZwVXmoJ4UMiHummqYGtGvDNf9ho3KtDKx?=
 =?us-ascii?Q?/h4mmRB5wkK851y80x71YuedIh+Mxys+z9kJCpa5aMniA3GALtat8tL1azCU?=
 =?us-ascii?Q?SoIV6mYyr+HbOrPFzvHpWi2tAY/7o2KStmNwEWLqUxjPfkvl3Fw9pTA0qv0J?=
 =?us-ascii?Q?f0ZwdDbzBw9IL5AQ0lu1inC9zwjX4NGl3CJ+l6WvwufvEOLmiclFJ/xLImNU?=
 =?us-ascii?Q?7wV0Lh2D55wEhh+tIIf28fCcFZ7kaByTfhqfvi+IVP6AjTMGzwx8eVhgwkYX?=
 =?us-ascii?Q?148N8LmDz39jUP7F1Fiz8MohD65zyY36YQGIAIuUWpHiGk1F8rIa68aQbgsz?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1748fb77-5e3e-43a2-e65a-08db3c759875
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 23:19:56.9271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmoJgXn2RquYz0JMP+b1ISMpO2Dm9fcy04a9ZynG9FMd3mk7dI7wvDDCWbPA4TCl+r47VfN6ypIz+A3gjQW7UADmTIpPup6iGEO+hh4MQ1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3547
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Thursday, March=
 23, 2023 10:36 AM
>=20
> From: Sean Christopherson <seanjc@google.com> Sent: Wednesday, March 22, =
2023
> 6:27 PM
> >
> > On Wed, Mar 22, 2023, Michael Kelley (LINUX) wrote:
> > > From: Dave Hansen <dave.hansen@intel.com> Sent: Wednesday, March 22, =
2023
> > 11:07 AM
> > > >
> > > > On 2/27/23 10:46, Michael Kelley wrote:
> > > > > diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> > > > > index 766ffe3..9f668d2 100644
> > > > > --- a/arch/x86/kernel/irq.c
> > > > > +++ b/arch/x86/kernel/irq.c
> > > > > @@ -211,6 +211,13 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
> > > > >  #ifdef CONFIG_X86_MCE_THRESHOLD
> > > > >  	sum +=3D irq_stats(cpu)->irq_threshold_count;
> > > > >  #endif
> > > > > +#ifdef CONFIG_X86_HV_CALLBACK_VECTOR
> > > > > +	sum +=3D irq_stats(cpu)->irq_hv_callback_count;
> > > > > +#endif
> > > > > +#if IS_ENABLED(CONFIG_HYPERV)
> > > > > +	sum +=3D irq_stats(cpu)->irq_hv_reenlightenment_count;
> > > > > +	sum +=3D irq_stats(cpu)->hyperv_stimer0_count;
> > > > > +#endif
> > > > >  #ifdef CONFIG_X86_MCE
> > > > >  	sum +=3D per_cpu(mce_exception_count, cpu);
> > > > >  	sum +=3D per_cpu(mce_poll_count, cpu);
> > > >
> > > > This seems fine, especially since arch_show_interrupts() has them. =
 But,
> > > > what's with the "#if IS_ENABLED" versus the plain #ifdef?  Is there=
 some
> > > > difference I'm missing?  Why not just be consistent with the other =
code
> > > > and use a plain #ifdef for both?
> > >
> > > I'm following the coding pattern in arch_show_interrupts(), in irq_cp=
ustat_t,
> > > and most other places that test CONFIG_HYPERV.   Maybe all those exis=
ting
> > > cases are a mis-application of Documentation/process/coding-style.rst
> > > Section 21, which prefers "if (IS_ENABLED(CONFIG_HYPERV))" over
> > > "#ifdef CONFIG_HYPERV".  "#if IS_ENABLED()" is not the same as
> > > "if (IS_ENABLED())".  :-)
> > >
> > >  Net, I don't have a strong preference either way.
> >
> > Using IS_ENABLED() is mandatory because CONFIG_HYPERV is a tri-state, i=
.e. can
> > be a module and thus #define CONFIG_HYPER_MODULE instead of CONFIG_HYPE=
RV.
>=20
> Ah, right.  Thanks.
>=20

x86 maintainers:   Any issues with picking up this patch for the 6.4 merge =
window?

Michael

