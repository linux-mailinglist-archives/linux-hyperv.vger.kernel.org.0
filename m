Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0D72C4BAB
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Nov 2020 00:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgKYXjh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Nov 2020 18:39:37 -0500
Received: from mail-dm6nam08on2127.outbound.protection.outlook.com ([40.107.102.127]:14067
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbgKYXjg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Nov 2020 18:39:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQQSIEeKsVXk3Kxzqf7JXvL1xYWt3I4kgiw/WqI4qAbPn6SIsiUSKsyeLcNWontDSZgEjcpnzimUOD1nplDOjnSQKZu3r62YJ5+nZpKaAICkYNDh0wDHz/Ioymz9+fuyf4FITHQuClz1truv2zzXpXz2wCBIjQI0iZf9Wielimj2SrwrKtmsz41n3hP/7PeSK6MiggmHfK9c/SOv+QN/X0THQd1mDi6l9GybvW3bEusGi1aqO/pa/03qJ9rLn3EQhBOhTlb1z2IkCatUUIBCaCFIVUDQUM3oH59tmYNJOoIal0aqKZCrdNzPQz3HeBTMbhdtsXGHdJgeY76U4p8cOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK8oImmuaKIxHHHwXIhRxfiK8sLuffk0A9YdVGgu08U=;
 b=CRunvOHPeV8xLxzOTP5o4TUL6ae9GHDv4oTHwTn97Q/6I4fzvtMFqbWziPSILkV++qRR77Vzdr5pLUfwoj8Ms7srsGB045MJzJfe++XZrT5lUGIJGoB8FjA/TWEgmyaxswQxuEQ3ic41n4vKJ/yzljQ+YHbeBhTtpjBvfrbWHLHgwBMA8uWlQ+sHfcscSiVEISfWrIYMPCXEBVCNtZTEiYHEbdzAPQgpSygda8uU3sQM8d9EP6teKIOYELnzLokPj5pzXgFk3Hmo3EMLXcba7x/KCSPHijLn6GMbg54EyOtoCwWGsBQV90OUpkSQQTcqyIgN3+iZPVstNAJcZVss2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK8oImmuaKIxHHHwXIhRxfiK8sLuffk0A9YdVGgu08U=;
 b=Yp3KIJdkAv+lTTuH71++vPoAC9it6FzXHmRd6jL1BPLNjbykrPyiYni4H8clknHTZSdZQn2rE4c8Bhr0w/CIHYidIFfd5kXhb+s0tFEcjG/Lou8JBcx0itmy39WLCMt4eH6CrpPs2t7CdQ7QkTv9fzoxXF1ySEnD8W0ZK0fxlpQ=
Received: from MW2PR2101MB1801.namprd21.prod.outlook.com (2603:10b6:302:5::20)
 by MWHPR2101MB0811.namprd21.prod.outlook.com (2603:10b6:301:7b::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.2; Wed, 25 Nov
 2020 23:39:31 +0000
Received: from MW2PR2101MB1801.namprd21.prod.outlook.com
 ([fe80::d8c7:7c95:5325:155a]) by MW2PR2101MB1801.namprd21.prod.outlook.com
 ([fe80::d8c7:7c95:5325:155a%4]) with mapi id 15.20.3632.008; Wed, 25 Nov 2020
 23:39:31 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     'Kairui Song' <kasong@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC:     'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Borislav Petkov' <bp@alien8.de>,
        'Ard Biesheuvel' <ardb@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        'Wei Liu' <wei.liu@kernel.org>,
        'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>,
        'Dave Young' <dyoung@redhat.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-hyperv@vger.kernel.org'" <linux-hyperv@vger.kernel.org>,
        "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 1/2] x86/kexec: Use up-to-dated screen_info copy to fill
 boot params
Thread-Topic: [PATCH 1/2] x86/kexec: Use up-to-dated screen_info copy to fill
 boot params
Thread-Index: AQHWogwCjQZIV623JkK79I6DLl0/K6nLvMBwgA3z0PA=
Date:   Wed, 25 Nov 2020 23:39:30 +0000
Message-ID: <MW2PR2101MB1801B19B018FE42150449D49BFFA1@MW2PR2101MB1801.namprd21.prod.outlook.com>
References: <20201014092429.1415040-1-kasong@redhat.com>
 <20201014092429.1415040-2-kasong@redhat.com>
 <MWHPR21MB0861EA2C8322A7C27404258CBFE20@MWHPR21MB0861.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB0861EA2C8322A7C27404258CBFE20@MWHPR21MB0861.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=aed533d9-f567-40b2-8207-f203b46f5346;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-17T01:24:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:3027:5564:f3db:e908]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40db5dc7-5888-46aa-41d2-08d8919b5b45
x-ms-traffictypediagnostic: MWHPR2101MB0811:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB08114F7A672D94A341900708BFFA1@MWHPR2101MB0811.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JBDeKL9Zjxlzt/MxrT2d2qvycMqUegAB+1TemtElPgnmozPTAeEEw+E8DN515X1xnRZ7gpxX6wjCSijhoNHqWACk6HPj1FfCPBNODLdBZ6hGli6O7r+KGVE/TZBnAQFk5OUr/aYCIqRzTXP5knMj5wJfDFiVoFr3qN2gOiO7Il13970cdYoE8GHsEqk3vgW2wCQ8oHvIiQ4m5qqzjAAPsR7V3W+EYV2Z29ssPcdWX8ksuv30pJUKMmpArDyLpihL1c/X6Ip0KkTm6BTw976bCQjhveMJKhpxUYE2Sig3c60u1m/aIUenHUunot4z3FVjEPd40Ngmw/HK9xSeJXz3e2LdKjccyXUWHFWeKRoN73BVzVxv6nNcCMfoiymBFkmAILBnMP2Qbg5cYr5lDBiWfS6a+f330dAd+RJtojGkZ+NxKqwCygd4RBSDSUX2YTT1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1801.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(66556008)(52536014)(64756008)(66476007)(7696005)(66946007)(66446008)(5660300002)(86362001)(186003)(6506007)(8990500004)(71200400001)(33656002)(9686003)(2906002)(316002)(55016002)(8936002)(110136005)(966005)(8676002)(4326008)(82950400001)(478600001)(83380400001)(82960400001)(10290500003)(7416002)(54906003)(76116006)(107886003)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DcF4Q0DlgBD/7ndesQWB20B9UrOhCepqtIeY4RuYTvV3FMlmjy3fJFu0IaTz?=
 =?us-ascii?Q?SZst1/4PV5+/o8IHLxxis16HwiyRWxcmuRxTTN0RUjogZGk3YvOJ/pgOVY6J?=
 =?us-ascii?Q?WCXEdMLduOVFhQ0fhkj4EPls+nbei4GN4XgUPjBKsaYSG7aeMmaBOSx/P90L?=
 =?us-ascii?Q?waZEDMrqgP1jZzm9ZgYqktnBV6TGMaLulxan4lKeEjM7h5RiGC5Cx2insZTi?=
 =?us-ascii?Q?OR/6vmnsnD1jUfBlNjxKeoai1DNJVnUxOViaeID55E5iIcDyxl1dg6Q1iwHX?=
 =?us-ascii?Q?PClxSV56RvW7pQnYhpRaW+dalKx4/PJF4BFafGvbweG9XBWpCq4jlvxax+MX?=
 =?us-ascii?Q?I2D8zOlMzEpYNa09KH7rwaWx1YZJYxEYTNgoofMdTUmVxIqFwxeETbPPr8LW?=
 =?us-ascii?Q?4zxur49ZS6KpDcJsVCb+kr/9M7oH9tCtp4RJ97EHIy2bvNSY6sWgtjPb77q2?=
 =?us-ascii?Q?NmPkZP28BCnJLRKSZyc1ylXLTEZpiqH4wbNSP5lzVjJSaD1wv3pKcuRqtYOu?=
 =?us-ascii?Q?B1lhPNXlTBhrvgufCCbhCCRiSjbl6LaKfMNZoe05LZpt0bNhMzdnWIgi5T4s?=
 =?us-ascii?Q?cm1tbhGsj33UVKKZrk/1i/ovJX+hh0OtUBwKJzsFJ8WSoDoUZi3j8Qe7f8iP?=
 =?us-ascii?Q?3j4pu7HRzBXqEsoJndRAN68QU3MAFD4MaRAfswYN07B2PObyt/uNsI0kQvGM?=
 =?us-ascii?Q?IRHD5cotUMKdNKONJcZakoBMlKFf7MTMvvAKb770khFE7kHMuVhv9naSti/K?=
 =?us-ascii?Q?3q9Swybr7Q9wdM2mY8Jr5VThWQusA3NxykbNc4/hUn82bYLy8b7dqPgGK8Bx?=
 =?us-ascii?Q?lIg/bPgyy/iba5EWD6dM/XD3+NEf7MKJcVi0Avx0xxMD3mqqkZiC2vKKRU/L?=
 =?us-ascii?Q?eiugIo6rFCIaGXwM5OQER8Yin6QaBuQzQgDSwF5EjNYvWQjeWsfto52lQ81J?=
 =?us-ascii?Q?o2yLAQqLiXNmI0SW1TzdSUXHtqgDP5z/1tarKc8p0/1WAnFYYnAPTduEFhMY?=
 =?us-ascii?Q?7uldW7FQV9gldsPAoOn9NfnMI4aUflrQk8azwJK4dxZAIUU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1801.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40db5dc7-5888-46aa-41d2-08d8919b5b45
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 23:39:30.6930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Jjrp0QCWOz2S8l8n4/nWRd/QtrzAvKk0TZHKmPStRK5uWbTJxoZoJJK6LLj2eUcA2/iPukcAw60w0OrIDjXHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0811
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dexuan Cui
> Sent: Monday, November 16, 2020 7:40 PM
> > diff --git a/arch/x86/kernel/kexec-bzimage64.c
> > b/arch/x86/kernel/kexec-bzimage64.c
> > index 57c2ecf43134..ce831f9448e7 100644
> > --- a/arch/x86/kernel/kexec-bzimage64.c
> > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > @@ -200,8 +200,7 @@ setup_boot_parameters(struct kimage *image, struct
> > boot_params *params,
> >  	params->hdr.hardware_subarch =3D boot_params.hdr.hardware_subarch;
> >
> >  	/* Copying screen_info will do? */
> > -	memcpy(&params->screen_info, &boot_params.screen_info,
> > -				sizeof(struct screen_info));
> > +	memcpy(&params->screen_info, &screen_info, sizeof(struct screen_info)=
);
> >
> >  	/* Fill in memsize later */
> >  	params->screen_info.ext_mem_k =3D 0;
> > --
>=20
> Hi Kairui,
> According to "man kexec", kdump/kexec can use 2 different syscalls to set=
 up
> the
> kdump kernel:
>=20
> -s (--kexec-file-syscall)
>        Specify that the new KEXEC_FILE_LOAD syscall should be used
> exclusively.
>=20
> -c (--kexec-syscall)
>        Specify that the old KEXEC_LOAD syscall should be used exclusively
> (the default).
>=20
> It looks I can only reproduce the call-trace
> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1867887#c5) with
> KEXEC_FILE_LOAD:
> I did kdump tests in Ubuntu 20.04 VM and by default the VM used the
> KEXEC_LOAD
> syscall and I couldn't reproduce the call-trace; after I added the "-s" p=
arameter
> to use
> the KEXEC_FILE_LOAD syscall, I could reproduce the call-trace and I can c=
onfirm
> your
> patch can eliminate the call-trace because the "efifb" driver doesn't eve=
n load
> with
> your patch.
>=20
> Your patch is only for the KEXEC_FILE_LOAD syscall, and I'm sure it's not=
 used in
> the code path of the KEXEC_LOAD syscall.
>=20
> So, in the case of the KEXEC_LOAD syscall, do you know how the *kexec*
> kernel's boot_params.screen_info.lfb_base is intialized? I haven't figure=
d it=20
> out yet.

FYI: in the case of the KEXEC_LOAD syscall, I think the lfb_base of the kex=
ec
kernel is pre-setup by the kexec tool (see the function setup_linux_vesafb(=
)):

https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/kexe=
c/arch/i386/x86-linux-setup.c#n126
static int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
{
	struct fb_fix_screeninfo fix;
	struct fb_var_screeninfo var;
	int fd;

	fd =3D open("/dev/fb0", O_RDONLY);
	if (-1 =3D=3D fd)
		return -1;

	if (-1 =3D=3D ioctl(fd, FBIOGET_FSCREENINFO, &fix))
		goto out;
	if (-1 =3D=3D ioctl(fd, FBIOGET_VSCREENINFO, &var))
		goto out;
	if (0 =3D=3D strcmp(fix.id, "VESA VGA")) {
		/* VIDEO_TYPE_VLFB */
		real_mode->orig_video_isVGA =3D 0x23;
	} else if (0 =3D=3D strcmp(fix.id, "EFI VGA")) {
		/* VIDEO_TYPE_EFI */
		real_mode->orig_video_isVGA =3D 0x70;
	} else if (arch_options.reuse_video_type) {
		int err;
		off_t offset =3D offsetof(typeof(*real_mode), orig_video_isVGA);

		/* blindly try old boot time video type */
		err =3D get_bootparam(&real_mode->orig_video_isVGA, offset, 1);
		if (err)
			goto out;
	} else {
		real_mode->orig_video_isVGA =3D 0;
		close(fd);
		return 0;
	}

When a Ubuntu 20.10 VM (kexec-tools-2.0.20) runs on Hyper-V, we should
fall into the last condition, i.e. setting
"real_mode->orig_video_isVGA =3D 0;", so the "efifb" driver does not load
in the kdump kernel.

Ubuntu 20.04 (kexec-tools-2.0.18) is a little old in that it does not have
Kairui's patch
https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?i=
d=3Dfb5a8792e6e4ee7de7ae3e06d193ea5beaaececc
, so it re-uses the VRAM location set up by the hyperv_fb driver, which
is undesirable because the "efifb" driver doesn't know it's accessing
an "incompatible" framebuffer -- IMO this may be just a small issue,
but anyay I hope Ubuntu 20.04's kexec-tools will pick up your patch.

So, now we should cover all the combinations if we use the latest kernel
and the latest kexec-tools, and the "efifb" driver in the kdump kernel
doesn't load.

Thanks,
-- Dexuan
