Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04236C6F6E
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Mar 2023 18:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCWRhg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Mar 2023 13:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjCWRga (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Mar 2023 13:36:30 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020015.outbound.protection.outlook.com [52.101.56.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB35279A1;
        Thu, 23 Mar 2023 10:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkmlDZT712O7Poy0nhd7ayE3bM7bxkC2Rz92xf2ZyU63N5Mhv01Jy66RYKhk+NuSekETWM7+aE0GkLgdwhFgQbn4XhaHLYnijLKrcSedBiClk68EfoMG9mFOQFqre3QL7lcbzVNs4xDM+CLrboStJSuIGnPRiWuzmkLxEiT34Wki33Kxg03f02qd8vmRIM6NuXkKp1IV7HYUwPK4McwlZyg6w0l5zse0MLySCEz5cx16kHiNhGbEAUBtbicIsq/KcklqfXp2NJGQg01v+O0Nx0sVafOAOHIUxde1ZOKfoKf2X6KDxs5nz0CMblsbZ3qLBj/NshWKIvhV8+sI/kD7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlaRvXpZ9vQZvD5OSl00a55XOpUY9sB8WNzmqBXq9J0=;
 b=kcUC+4vOYG686DI1WkzaSYfcDVxCfNmf5rw8u4+O8O0WDM+dG6zXKkSkBwprGWj4zjM/imFJOKijrgLSIh2DMxqVS4PD3KOrJaF+PMHewWhpSraUaXWFP7x8RUfrWC4iChihUlz8uQQK0oQDORE416Hbf8+CUhCw4N45rWQwXPom1c0oGu+JSoT4mW4rLJwJWYzdJgORZVwmbYAEPSAu6FrJs58xAmzDB2t+hzgMY1dM+YJugtDBEOMNtIEGuxRrVoIDqC/rQsXzv9DOb5An9QC5RHpuUg/xsJ7YaDLER3jtlnCaZGKVZeXTYOgKCdOhseUIEaiaNOOgZIC2yX0+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlaRvXpZ9vQZvD5OSl00a55XOpUY9sB8WNzmqBXq9J0=;
 b=jrcF5a/GZT51M8gjWL8xc41w48RFBQqpkGTgNcGe12buKPvAOrWgCNITeJMMk+bq/fst6gkBrTHGLubO4Lo3tlLePBQDGR3akcB2Xxqxlb0gF5WVgK9vv8bF413BTVRCId+NixavcSObNW38R7vZ40OVUsLAQwGMCj93PqFKhjQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3478.namprd21.prod.outlook.com (2603:10b6:8:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.6; Thu, 23 Mar
 2023 17:36:23 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6254.007; Thu, 23 Mar 2023
 17:36:23 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     Dave Hansen <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/irq: Add hardcoded hypervisor interrupts to
 /proc/stat
Thread-Topic: [PATCH 1/1] x86/irq: Add hardcoded hypervisor interrupts to
 /proc/stat
Thread-Index: AQHZStvOKEpex/oSu0efNAklHfBImK8HPJyAgAAZNICAAGGUAIABDrgg
Date:   Thu, 23 Mar 2023 17:36:23 +0000
Message-ID: <BYAPR21MB1688CF3ABAF181A17443BF3FD7879@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1677523568-50263-1-git-send-email-mikelley@microsoft.com>
 <dce372bd-e63c-f24c-5b79-1ef65fd1e59a@intel.com>
 <BYAPR21MB16884B3D0E15E501A7BB8E78D7869@BYAPR21MB1688.namprd21.prod.outlook.com>
 <ZBuq4KjU2ekKk+iS@google.com>
In-Reply-To: <ZBuq4KjU2ekKk+iS@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e488351e-066c-48af-9936-c8c394f6f831;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-23T17:35:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3478:EE_
x-ms-office365-filtering-correlation-id: 53fde23a-2381-47b8-8960-08db2bc51f19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4hw1AZUsKSUG3diSVl15uFaTwaKHr6TLBVjIFHf8zTdm+VTJovy/qiiuixsKuHwLDvsBMFwKjZi47YZEi3Hv87VbRk6YOtYnVm4MsiKfCSHxaCubyuBytUcykKLXZHwfSbSwu8LcW/PlHIH9+9/hhy7EBclF5QUhKv+aG+EFOAiknKpuBgFmVkNut0WvmWo6FpVV08Vg9qrGEYYGf2rKa7q8N3M2Xs1PjgdvmZgKB4nU4+Mm+r4P9M3qwmdulvbZnpZ8f/dZSKyPZ7XX105h5S+g8L9JNP69tJabSPwvhJoqWIHANzcrUsNp/m+7Ik+46Iw9uNPgdfxRA2KNQTTHpIUvBBYB14BUSSu+38OGv5vVQE0tRia0/qtmxw26ZGoLalEIhpYieTCGtTcgDN2mEAEnOljXHkJlpD+Ef1e9ViUfxX/XVEQSZiK4N66vOB2ke4plOeLzxtF4/SnMqNjtTPq9vxgjmU+OzFyq6rTN2611XDKUB7pdZ6OA14oFOifXVlj18ZLjeOajmHuMJKiT1UNTcghf87u9yhNf4TkVWOi7XdRLqaKOi132UvpToK5UQkjOu8e2X5Lx+nTonpR9hp95OCVddC/9wvJrZjrfPYVQ1TropRkJeqWI09Ew5NxYleQxgLkMdb5IFNRJcW4MzCGNodcx1PWllSUFB3rNbn4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199018)(8936002)(41300700001)(52536014)(55016003)(478600001)(54906003)(71200400001)(10290500003)(316002)(33656002)(86362001)(7696005)(66556008)(66446008)(66476007)(66946007)(8990500004)(8676002)(6916009)(76116006)(82960400001)(82950400001)(64756008)(4326008)(122000001)(186003)(38070700005)(38100700002)(2906002)(53546011)(7416002)(9686003)(26005)(5660300002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B+NipqLy7qTrgjqLn9uiy4sd9qYH8Bn6Y4Ee+QabmeKrju9BSA2KRe/YJmR1?=
 =?us-ascii?Q?kvYL6/PNmCV/p8jP4HOi2vXmJF/rndMp8tR2mVfjbTbMY+jmAxEsZkWtbXQu?=
 =?us-ascii?Q?OuxjhPgPKWgXbPqAvxBuejY0onnHj3DvL9dg2IqB39MHfRn9/UA2HAaQrJWR?=
 =?us-ascii?Q?Q4kPjbzrUTUYtWk89pB2VFqnsWdjGvcX+T1ktriCY3N0q5tgGUvn2nQTIqJm?=
 =?us-ascii?Q?A0l3KA6zqjtw1z1JGLJuHItLN1npz/ugw0PgboerpIJw3LT0BAJYm0iV6doq?=
 =?us-ascii?Q?5/y6lW49VvlOVH2lXhORiH/B0IsyFJ47LR47y2sUWlO1K9dEwhBFNOYQixgv?=
 =?us-ascii?Q?9fe+vn8bLIUrMoeIqCXH4oeP/CgaS3RUOGrCxY1EBsLg8xDkB9Wv4VLEMCa4?=
 =?us-ascii?Q?QrnC5phDbdSlqdBvbOaT4XEfs4xwNyS2ll0mjFpkzkaKQ4VerHqGEGUJa/yv?=
 =?us-ascii?Q?hhupGpJHZv4OKqVPTAOb+JXen4pIfvImdn3IRFulGmmrWHgBdatYkqGQvcT2?=
 =?us-ascii?Q?HpFiOp/dZ5nABta9i/DSNYCjQERk+rqsFnlku3sfzpfYxUj5x+6Pepyo63uJ?=
 =?us-ascii?Q?s+/aaXPB2Od4BCt1DgXz9M0CcjeoGE0UDxcITAMAVV6Y/YZABQSFTtY/+9zG?=
 =?us-ascii?Q?v7pOFHs0iUX/95iC37UPMoupITOmAgxX4DVxq9m4582co+cxQOerCntikH2b?=
 =?us-ascii?Q?O0wYyy0BN8AJaz8leuOUe6dA9mGSVnEcd+QF94s/L84hKmQyJQwuyfv5UV2w?=
 =?us-ascii?Q?RIoXuIUDvqTi1QDRn4ocHKCLcKWe/CyFSokq0UlP1Q7BvFiPrc2D9iKQlJJL?=
 =?us-ascii?Q?n16w8iGbkc2CTZ+lZA96XOUR5ETg3xZjPmbD+7wuBkqMbK+1sH7/7g5d9xNo?=
 =?us-ascii?Q?O7U7ypAvtROFX/jgAAcfOdqWYVBkjW+PpdkI21S/aZTHZFo/1TgUPXM+uJBD?=
 =?us-ascii?Q?qQq2OmZgax9E5NKuUSLA/tpJDrCI9teG1TX1hT6gpp4fDumWRDM2+KVrjgA6?=
 =?us-ascii?Q?UQSn/Bo0pBppiqf0nirEjdPN+N/wsOLaWWi4jRKSa71aMWln9ARpcbD0Zq5x?=
 =?us-ascii?Q?TOTJMpldgnSxty3mm5XfMJRWa0zQbcXZsVcNv4o88kxP4aV9wSEP08vYZhnQ?=
 =?us-ascii?Q?5FJYoPiL9V6cZxo4AwBOT5nf/os9hGOs3NdIU66fDnm4asUtQ7Wl5QTtnmoB?=
 =?us-ascii?Q?SWfskXK40CRbzbYCcrVgA2QrHRNihfogTGw+cQ29voSgq4Xx0Csf/kckzWaW?=
 =?us-ascii?Q?pepQAQ5E3/RB7gwcq/qDiWCzeuvF3HIouiX5q+7xDDPeONws19LjQ8A2QTRb?=
 =?us-ascii?Q?HPAW+zVVu163wClGAcrEKRPYm6YRhJUxptbdUSRrFaN7qgeJ+VrvRSNkB5Vi?=
 =?us-ascii?Q?S4wBEBaXeb7+pHU5Za2Tk38rA3YUReF3r22MXPdzfITyvNuVCwevYblfaI3Q?=
 =?us-ascii?Q?OZD0vFf0k/G0AoChpO+onxH42E7fVpMpYALknG1Gesc8SMXvtqA0fXPydo6+?=
 =?us-ascii?Q?I08YpXZx4s5dksdG3p9wPJpq3XN1ZB2mfvDj1jj/ezBKxAXwQYKx3nv1Bx0T?=
 =?us-ascii?Q?fkckXOdDzhgjdRluELIZGCfoCJlxnl+6T33a2GaL7KaYUH9AVHWWxTzdqPA8?=
 =?us-ascii?Q?DQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fde23a-2381-47b8-8960-08db2bc51f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 17:36:23.2983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dfv+zOfClt4Js8tSKzQPzf8a/7mmbuqd4kDuirYlxLE/JNf0bqT9WsvO8OGbIugFmzd0ksKDq7i1ZE8KmX2hmWTdkckfVecgs88zKeCEG+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3478
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sean Christopherson <seanjc@google.com> Sent: Wednesday, March 22, 20=
23 6:27 PM
>=20
> On Wed, Mar 22, 2023, Michael Kelley (LINUX) wrote:
> > From: Dave Hansen <dave.hansen@intel.com> Sent: Wednesday, March 22, 20=
23
> 11:07 AM
> > >
> > > On 2/27/23 10:46, Michael Kelley wrote:
> > > > diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> > > > index 766ffe3..9f668d2 100644
> > > > --- a/arch/x86/kernel/irq.c
> > > > +++ b/arch/x86/kernel/irq.c
> > > > @@ -211,6 +211,13 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
> > > >  #ifdef CONFIG_X86_MCE_THRESHOLD
> > > >  	sum +=3D irq_stats(cpu)->irq_threshold_count;
> > > >  #endif
> > > > +#ifdef CONFIG_X86_HV_CALLBACK_VECTOR
> > > > +	sum +=3D irq_stats(cpu)->irq_hv_callback_count;
> > > > +#endif
> > > > +#if IS_ENABLED(CONFIG_HYPERV)
> > > > +	sum +=3D irq_stats(cpu)->irq_hv_reenlightenment_count;
> > > > +	sum +=3D irq_stats(cpu)->hyperv_stimer0_count;
> > > > +#endif
> > > >  #ifdef CONFIG_X86_MCE
> > > >  	sum +=3D per_cpu(mce_exception_count, cpu);
> > > >  	sum +=3D per_cpu(mce_poll_count, cpu);
> > >
> > > This seems fine, especially since arch_show_interrupts() has them.  B=
ut,
> > > what's with the "#if IS_ENABLED" versus the plain #ifdef?  Is there s=
ome
> > > difference I'm missing?  Why not just be consistent with the other co=
de
> > > and use a plain #ifdef for both?
> >
> > I'm following the coding pattern in arch_show_interrupts(), in irq_cpus=
tat_t,
> > and most other places that test CONFIG_HYPERV.   Maybe all those existi=
ng
> > cases are a mis-application of Documentation/process/coding-style.rst
> > Section 21, which prefers "if (IS_ENABLED(CONFIG_HYPERV))" over
> > "#ifdef CONFIG_HYPERV".  "#if IS_ENABLED()" is not the same as
> > "if (IS_ENABLED())".  :-)
> >
> >  Net, I don't have a strong preference either way.
>=20
> Using IS_ENABLED() is mandatory because CONFIG_HYPERV is a tri-state, i.e=
. can
> be a module and thus #define CONFIG_HYPER_MODULE instead of CONFIG_HYPERV=
.

Ah, right.  Thanks.

Michael
