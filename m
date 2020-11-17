Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450DE2B57FD
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Nov 2020 04:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgKQDjr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Nov 2020 22:39:47 -0500
Received: from mail-mw2nam12on2135.outbound.protection.outlook.com ([40.107.244.135]:64320
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbgKQDjr (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Nov 2020 22:39:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIq0VR6ePd2mh6M4kgGkhNCq/k3nRoWzYGtIXbutifd4btdD/3R1EXFzBaQis7gHMmNPkaKLiGQ+SyzyEP+xioC5jK+4KzFBpS0v/ZlrcKPqnOAQS1ffZ0ov73hH/2oBlEeelrzzlZYIiuefq/UwWPq76zr80l9R2GrTjfDu+GFcdHD89YccCescUG2ZlBcYtTUYpkeN2f/kaZvz9xL9ZIX/ez19t0WbqbaT+j70HsI4IBkQb+TUwxoFYBiAu3KgVLk9duUP7VHS58ZdvdyudHrO99jZOzoSWl2qD0juodmwuOkcr0/ZM1xpaW3hCTsQHwNVoNaz4kfPArrA5BOZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpAJP0aAl/yvXWfOdrHWrufeq0ys7IlY/wKiUlFYpck=;
 b=BzXgKbwEXRd2iKaYNDc67wxVZr/2lWCZPil4y8lOqyVnglo8HMlY/RCp2P9CJobUoGls9+ebtRX6tZvKKnkim2FKb+oBBQqi/EW6Ohs822WH2yiNfWVTuFLRwQcmw+fy+wb9Dorbohh8peZk4n2EFKRxOCi94ZRX+A42YJibJfcJlkcIApOkqAY6L01MgYDiNd3uzlHk0Ffv/FyKXd+29svv7sINpMPb6vStj7WpKpgYWUVYEIXxv1tbSfV4rFLGoVdKDVDwEYDNRvNNsSp5qW/sRj/vwbf9mECHViqal/RXN99LjwRH9qeEPWAIRGpVUkmSHCwp4bPMrmBB6DVSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpAJP0aAl/yvXWfOdrHWrufeq0ys7IlY/wKiUlFYpck=;
 b=iPMEmo5ILc78U1f+cqKpm5ItTLpf9k2i36mbyNwtuHDjt7lsrmAdX+N5cxVSbmQu5v7rhgL5+MJ7hBSYa0ubRb8RJU3/AF4NIIi+igGTBgTQmaAMMpL6EZO+O0N3W9Jct3nRaCW3JdOrk9BVLJosULRSC+0IYNBgp2rqmVbjH0c=
Received: from MWHPR21MB0861.namprd21.prod.outlook.com (2603:10b6:300:77::15)
 by MW2PR2101MB0905.namprd21.prod.outlook.com (2603:10b6:302:10::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.4; Tue, 17 Nov
 2020 03:39:44 +0000
Received: from MWHPR21MB0861.namprd21.prod.outlook.com
 ([fe80::1583:35ab:fa84:4f89]) by MWHPR21MB0861.namprd21.prod.outlook.com
 ([fe80::1583:35ab:fa84:4f89%2]) with mapi id 15.20.3611.004; Tue, 17 Nov 2020
 03:39:44 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Kairui Song <kasong@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Young <dyoung@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: RE: [PATCH 1/2] x86/kexec: Use up-to-dated screen_info copy to fill
 boot params
Thread-Topic: [PATCH 1/2] x86/kexec: Use up-to-dated screen_info copy to fill
 boot params
Thread-Index: AQHWogwCjQZIV623JkK79I6DLl0/K6nLvMBw
Date:   Tue, 17 Nov 2020 03:39:44 +0000
Message-ID: <MWHPR21MB0861EA2C8322A7C27404258CBFE20@MWHPR21MB0861.namprd21.prod.outlook.com>
References: <20201014092429.1415040-1-kasong@redhat.com>
 <20201014092429.1415040-2-kasong@redhat.com>
In-Reply-To: <20201014092429.1415040-2-kasong@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=aed533d9-f567-40b2-8207-f203b46f5346;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-17T01:24:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:e85b:a8f7:bcc5:c49e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5876694a-1153-42d7-6b55-08d88aaa6caa
x-ms-traffictypediagnostic: MW2PR2101MB0905:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0905F3AC5025440C066E9AAFBFE20@MW2PR2101MB0905.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:534;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9lZ10mCT6skIyQ64D6TpLyvpsv84CySCZhHkzgQkeS8ij4K9QeA2sNAfLtD8Ea43iDD/QSDQOH4UulzSZY7lUudOpzG2WhLGTxnwVZ4PigqcUQ2nevZk3ZSKru2nLfHVEvUhKhYCMSzw0xKnKqE4Pz1eblKjNTfcXUP+gn9N+uR4U1B/MH7ceUJAcZszgEHz3B92HnaYH7yst+yvVqCfFmPlEBlFwkeNzNFvwCo1WQOnY2tVdxJvkCG2ydSUyqjyGAw+Mh7wlEBoT+wEcaH469Ulw8nsjZXFBkw2Nr6DUWATwn2yUOhJcmyhJMDd6RNauYu1YIf/mi9pHw5F6JDTiOKdr6Eufj/iIqBFLc8bwXS19DEzneniyU/lxFQZYiZXPAo498iSrXKMW3iwQaBOZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB0861.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(82960400001)(82950400001)(71200400001)(478600001)(83380400001)(64756008)(66556008)(8990500004)(33656002)(76116006)(66946007)(66446008)(5660300002)(52536014)(66476007)(316002)(110136005)(9686003)(54906003)(53546011)(6506007)(55016002)(7696005)(186003)(2906002)(4326008)(8676002)(7416002)(86362001)(10290500003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EHK16hMklNHnOh/Yq9KeD1WuNINFal9IuJpw9f1nxz9NCFtDcD3nxOdjBTZH?=
 =?us-ascii?Q?Ml10LTTBI8m6SQOVZSYdfSBN1Gk98h+bWzVbCxnJBs0ldEjHHybtKlrNqpJb?=
 =?us-ascii?Q?XBEZM+TkVsc6RUNXMzrclIHWyngZSozppFWNjZgu/GVSNMyNxxIN6pwrJ5gY?=
 =?us-ascii?Q?oYmQk9T1OwKl68IxB3EEkZikT47J3dFjcuh6+oAeT1fTb+uqZ7xRsZynoD2m?=
 =?us-ascii?Q?oxFZafR2wZZ1HhaHyaRXt3gVzu5WpFYNCZk10HvJ8Ge03pw+u9RAN9aUKvPx?=
 =?us-ascii?Q?OGlOWcWI95J5KS4UnmADCBXOCyXffxH1YxLK1d9uxdhQvH3y3Hn5Xz5Jo9Ra?=
 =?us-ascii?Q?GtZNIFImrXVRSHeOu2yO6d9x1RybqN67OGMu/4ovGsXValnQz0gXQfePvXXd?=
 =?us-ascii?Q?NcMY3a59v8YWL8z7BxT96kTlgZtjqCNsWU5quQbKd2jZzZTS/1sBxBJrnn5P?=
 =?us-ascii?Q?darZ09dPHcqI7ewMLvprCE5lv1UpNn97K7lL2SGWSncvDs4oa1JLzhv4cBuF?=
 =?us-ascii?Q?wgfzpI74/G0fVCVHClB+BMKRjKYE5zgq1w8i4vjuQEfmoHCZdi4Ak4zbLR19?=
 =?us-ascii?Q?tfA4dHOXxAqTGpaO8XLTIglki9TgqRB40OTijuvhPawjFrYJ3n3c6IM2nX89?=
 =?us-ascii?Q?GCKdnOYii67NOPv6tX6nJmpbeo2O6S+rTWMB7NdvDWZ09jX7FcU0K6k6SECK?=
 =?us-ascii?Q?aL/oY5TJT0bsbU7tLbXwNj/imp9qJ7Z6IdfDwgPHyrtyMmTJNw+EfDjUcUJY?=
 =?us-ascii?Q?WgLX+uUpUcT0g9797g5pYTUdFSjpK6B9I3NVohYIkrB1WNCXZYkgH2545l1A?=
 =?us-ascii?Q?YHosv/AWP9lGJTT8trSnSNQFEyC0qxGp6D//hDJGQv8+Fkfoy23hPM1mZGNo?=
 =?us-ascii?Q?keQ84smHiNxfxC6g8DkBrqZxm0cJNfUG4eOofiIyZaPmmFwGXQUC3P56+9E6?=
 =?us-ascii?Q?5HfmHruI5th0/q0xAUttRA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB0861.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5876694a-1153-42d7-6b55-08d88aaa6caa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 03:39:44.3377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mi0Y060U1VzO7Y5Ix5nRSDMs0FoLZZuK8XeFObsllI+/uiCwzVfARgSHKKYbfYJ3QxruXvbE7BfJ8lEo7jvLNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0905
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Kairui Song <kasong@redhat.com>
> Sent: Wednesday, October 14, 2020 2:24 AM
> To: linux-kernel@vger.kernel.org
>=20
> kexec_file_load now just reuse the old boot_params.screen_info.
> But if drivers have change the hardware state, boot_param.screen_info
> could contain invalid info.
>=20
> For example, the video type might be no longer VGA, or frame buffer
> address changed. If kexec kernel keep using the old screen_info,
> kexec'ed kernel may attempt to write to an invalid framebuffer
> memory region.
>=20
> There are two screen_info globally available, boot_params.screen_info
> and screen_info. Later one is a copy, and could be updated by drivers.
>=20
> So let kexec_file_load use the updated copy.
>=20
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/kexec-bzimage64.c
> b/arch/x86/kernel/kexec-bzimage64.c
> index 57c2ecf43134..ce831f9448e7 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -200,8 +200,7 @@ setup_boot_parameters(struct kimage *image, struct
> boot_params *params,
>  	params->hdr.hardware_subarch =3D boot_params.hdr.hardware_subarch;
>=20
>  	/* Copying screen_info will do? */
> -	memcpy(&params->screen_info, &boot_params.screen_info,
> -				sizeof(struct screen_info));
> +	memcpy(&params->screen_info, &screen_info, sizeof(struct screen_info));
>=20
>  	/* Fill in memsize later */
>  	params->screen_info.ext_mem_k =3D 0;
> --

Hi Kairui,
According to "man kexec", kdump/kexec can use 2 different syscalls to set u=
p the
kdump kernel:

-s (--kexec-file-syscall)
       Specify that the new KEXEC_FILE_LOAD syscall should be used exclusiv=
ely.

-c (--kexec-syscall)
       Specify that the old KEXEC_LOAD syscall should be used exclusively (=
the default).

It looks I can only reproduce the call-trace=20
(https://bugzilla.redhat.com/show_bug.cgi?id=3D1867887#c5) with KEXEC_FILE_=
LOAD:
I did kdump tests in Ubuntu 20.04 VM and by default the VM used the KEXEC_L=
OAD
syscall and I couldn't reproduce the call-trace; after I added the "-s" par=
ameter to use
the KEXEC_FILE_LOAD syscall, I could reproduce the call-trace and I can con=
firm your
patch can eliminate the call-trace because the "efifb" driver doesn't even =
load with=20
your patch.

Your patch is only for the KEXEC_FILE_LOAD syscall, and I'm sure it's not u=
sed in the
code path of the KEXEC_LOAD syscall.

So, in the case of the KEXEC_LOAD syscall, do you know how the *kexec* kern=
el's
boot_params.screen_info.lfb_base is intialized? I haven't figured it out ye=
t.

Thanks,
-- Dexuan
