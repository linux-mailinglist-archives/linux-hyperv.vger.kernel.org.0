Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C569196C
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Aug 2019 22:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfHRUGU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 18 Aug 2019 16:06:20 -0400
Received: from mail-eopbgr700110.outbound.protection.outlook.com ([40.107.70.110]:3168
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726907AbfHRUGU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 18 Aug 2019 16:06:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjjN8Ks3i9VX5JsggUwk5QnIYcibix1rp064CuXjtG35GGlm+n1sYNGc8+hmCdsuciKBg3WUZizExYQdjldTCTvDyRy9+YN+aOIlRko2QK2o4Er7FvTN+Yzm8RPY5wj8/LqJ+2O6iR5r/QjkevQcAk8TUDHThnjmUUpiZQ74o6PruVj1GRG7VxI5dE4gm0bsb6vxwpUVR0wqLq1uamukTXyEE6rtcGILgz6xgL7T0MvpLG9+hg8y8xxgiQOEd5QLLZpggkfSiooIUYkpTyd8f4F0tjKBKtPolrnlcCD3OAQ2RnNieKlJlwzetrUKW8cOsMFu1xHOtpt92RIsALeFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsrGnz33H0IuUMRJGz4o3+tczp7MC2pRyPNN3iAo/3E=;
 b=CGuNuQOevzBjnHZr3VL4Bjp4RgaV+Cs1N0yuUg0SNoTD2N/pjXJmD7/9Ok8xB5FuXEH1rGjRzHvKSxTynPXFLfP3XfVEZ0zq6R8+BeuyoC7p0VOo5BCgKj/Jeh04KRUc22pEa6rKD7CYTkVFueaQ5ib11H7fzZ47OCD96cdq9JgocvpDmI8dDgRCcuwJBVA3ToSk1W7J9LGhOn5kBpnR0CTxaUVI4DG/JUTcupvAUrXmnFdmIwwIVWGykciW/Cf/Xh9o2aPP1qKrC/fRYbc0+f494GIeNvxUqU2aaV4qe+MwvcxvM1Ag1ZUyDqu8+DS1Xk3c4VeCrwS+PQ5795c6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsrGnz33H0IuUMRJGz4o3+tczp7MC2pRyPNN3iAo/3E=;
 b=btHOIJkHeTz6AQ7DHlBp0C7TCB7/ZqHtEGNzKd+hl4YdB/3wHgfE2/s/NsJUdvqyzZ0yFaJtAPUtBrKvQjisgT0gNntKt3ytX4XcMW713iZ20wwW8s/5ZUiSkO3SIrBGAgupVi7vbWjYYGpa+p4f49I2PyX15d9ifxH5DCmlV/A=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.3; Sun, 18 Aug 2019 20:06:11 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Sun, 18 Aug 2019
 20:06:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Hu <weh@microsoft.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Iouri Tarassov <iourit@microsoft.com>
Subject: RE: [PATCH] video: hyperv: hyperv_fb: Obtain screen resolution from
 Hyper-V host
Thread-Topic: [PATCH] video: hyperv: hyperv_fb: Obtain screen resolution from
 Hyper-V host
Thread-Index: AQHVUb0g581mp+FsUUiW9Yvczi+TXacBWbxw
Date:   Sun, 18 Aug 2019 20:06:10 +0000
Message-ID: <DM5PR21MB01378677679802BD9A6B160BD7A90@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190813095351.1780-1-weh@microsoft.com>
In-Reply-To: <20190813095351.1780-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-18T20:06:08.0921586Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d1bdb012-514e-469e-9528-ed50da584e91;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fb00102-9d5d-4a37-f757-08d7241783b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0137;
x-ms-traffictypediagnostic: DM5PR21MB0137:|DM5PR21MB0137:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB013713554E5B6A8DB58601BAD7A90@DM5PR21MB0137.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 01334458E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(54094003)(199004)(189003)(52536014)(66476007)(66446008)(64756008)(66556008)(66066001)(10290500003)(6116002)(76176011)(1511001)(3846002)(81166006)(8676002)(81156014)(102836004)(6506007)(66946007)(14454004)(229853002)(76116006)(74316002)(305945005)(8990500004)(10090500001)(7696005)(7736002)(99286004)(486006)(33656002)(25786009)(316002)(446003)(476003)(478600001)(186003)(6246003)(11346002)(110136005)(2201001)(2906002)(22452003)(86362001)(5660300002)(8936002)(55016002)(6436002)(9686003)(6636002)(71190400001)(71200400001)(256004)(2501003)(53936002)(14444005)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0137;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G7uRj+zA0yOvp9Q8qvO8a+Azm9Owwzs1szSCQFjqLpdWe95qD1n1c9TTKNlKUXPq9a6ReBRyxxEUUFZq/jW0yHkbhyp2FgzkwZWJXABr40MBogDi+ps5BB4G7Ci/Fy1+EFVLJfuC9MfnfrGhqfsCtTFIfniadDEG87CkiPAFitIgyogVmeReFo8oWkK9neSsIYwm+3oUWzofewvEt0gI7E6BKhDkxIN20bZsX7hxzEiwmG8o6jITq75h2JAM/5B22urg5EOgVY8o6RAEGytS8MXx58MlEUp7D0yxHAQtw5whR5z6FhKf1bRVCHqTE26LFhXMITfoGmpDrkOe39zkvbEDsdh3o3e4LXhvSbI3oZU7MSJQ3qfz3KGYLTqO+AW6qoyat8t5q+Kqd4WmPVsgzXfcwq6h4RImYQWqSIP5CiY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb00102-9d5d-4a37-f757-08d7241783b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2019 20:06:10.6840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHENPVfHRhPVA6Lfd/qTCtOFb5cA36f2kyXcyIUb87fDJPmwW6Ar58ZnDWnY2VDB1pY2FeEITxjXXBkOMDDk1Lh8peIxnITGLACTSoWeAh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0137
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Tuesday, August 13, 2019 2:55 AM
>=20
> Beginning from Windows 10 RS5+, VM screen resolution is obtained from hos=
t.
> The "video=3Dhyperv_fb" boot time option is not needed, but still can be
> used to overwrite the VM resolution. The VM resolution on the host could =
be

I would word this as "used to override what the host specifies."

> set by executing the powershell "set-vmvideo" command.
>=20
> Signed-off-by: Iouri Tarassov <iourit@microsoft.com>
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>  drivers/video/fbdev/hyperv_fb.c | 136 +++++++++++++++++++++++++++++---
>  1 file changed, 125 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv=
_fb.c
> index 00f5bdcc6c6f..1042f3311fa2 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -23,6 +23,14 @@
>   *
>   * Portrait orientation is also supported:
>   *     For example: video=3Dhyperv_fb:864x1152
> + *
> + * When a Windows 10 RS5+ host is used, the virtual machine screen
> + * resolution is obtained from the host. The "video=3Dhyperv_fb" option =
is
> + * not needed, but still can be used to overwrite the VM resolution. The

As above, "but still can be used to override what the host specifies."

> + * VM resolution on the host could be set by executing the powershell
> + * "set-vmvideo" command. For example
> + *     set-vmvideo -vmname name -horizontalresolution:1920 \
> + * -verticalresolution:1200 -resolutiontype single
>   */
>=20
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -44,6 +52,7 @@
>  #define SYNTHVID_VERSION(major, minor) ((minor) << 16 | (major))
>  #define SYNTHVID_VERSION_WIN7 SYNTHVID_VERSION(3, 0)
>  #define SYNTHVID_VERSION_WIN8 SYNTHVID_VERSION(3, 2)
> +#define SYNTHVID_VERSION_WIN10 SYNTHVID_VERSION(3, 5)
>=20
>  #define SYNTHVID_DEPTH_WIN7 16
>  #define SYNTHVID_DEPTH_WIN8 32
> @@ -82,16 +91,25 @@ enum synthvid_msg_type {
>  	SYNTHVID_POINTER_SHAPE		=3D 8,
>  	SYNTHVID_FEATURE_CHANGE		=3D 9,
>  	SYNTHVID_DIRT			=3D 10,
> +	SYNTHVID_RESOLUTION_REQUEST	=3D 13,
> +	SYNTHVID_RESOLUTION_RESPONSE	=3D 14,
>=20
> -	SYNTHVID_MAX			=3D 11
> +	SYNTHVID_MAX			=3D 15
>  };
>=20
> +#define		SYNTHVID_EDID_BLOCK_SIZE	128
> +#define		SYNTHVID_MAX_RESOLUTION_COUNT	64
> +
> +struct hvd_screen_info {
> +	u16 width;
> +	u16 height;
> +} __packed;
> +
>  struct synthvid_msg_hdr {
>  	u32 type;
>  	u32 size;  /* size of this header + payload after this field*/
>  } __packed;
>=20
> -
>  struct synthvid_version_req {
>  	u32 version;
>  } __packed;
> @@ -102,6 +120,18 @@ struct synthvid_version_resp {
>  	u8 max_video_outputs;
>  } __packed;
>=20
> +struct synthvid_supported_resolution_req {
> +	u8 maximum_resolution_count;
> +} __packed;
> +
> +struct synthvid_supported_resolution_resp {
> +	u8 edid_block[SYNTHVID_EDID_BLOCK_SIZE];
> +	u8 resolution_count;
> +	u8 default_resolution_index;
> +	u8 is_standard;
> +	struct hvd_screen_info supported_resolution[1];

It seems like the array size should be SYNTHVID_MAX_RESOLUTION_COUNT.
Otherwise code might not factor in the full size of the data structure, suc=
h
as in the memset() call in synthvid_get_supported_resolution().

> +} __packed;
> +
>  struct synthvid_vram_location {
>  	u64 user_ctx;
>  	u8 is_vram_gpa_specified;
> @@ -187,6 +217,8 @@ struct synthvid_msg {
>  		struct synthvid_pointer_shape ptr_shape;
>  		struct synthvid_feature_change feature_chg;
>  		struct synthvid_dirt dirt;
> +		struct synthvid_supported_resolution_req resolution_req;
> +		struct synthvid_supported_resolution_resp resolution_resp;
>  	};
>  } __packed;
>=20
> @@ -224,6 +256,8 @@ struct hvfb_par {
>=20
>  static uint screen_width =3D HVFB_WIDTH;
>  static uint screen_height =3D HVFB_HEIGHT;
> +static uint screen_width_max =3D HVFB_WIDTH;
> +static uint screen_height_max =3D HVFB_HEIGHT;
>  static uint screen_depth;
>  static uint screen_fb_size;
>=20
> @@ -354,6 +388,7 @@ static void synthvid_recv_sub(struct hv_device *hdev)
>=20
>  	/* Complete the wait event */
>  	if (msg->vid_hdr.type =3D=3D SYNTHVID_VERSION_RESPONSE ||
> +	    msg->vid_hdr.type =3D=3D SYNTHVID_RESOLUTION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_VRAM_LOCATION_ACK) {
>  		memcpy(par->init_buf, msg, MAX_VMBUS_PKT_SIZE);
>  		complete(&par->wait);
> @@ -428,6 +463,64 @@ static int synthvid_negotiate_ver(struct hv_device *=
hdev, u32 ver)
>  	}
>=20
>  	par->synthvid_version =3D ver;
> +	pr_info("Synthvid Version major %d, minor %d\n",
> +		ver & 0x0000ffff, (ver & 0xffff0000) >> 16);
> +
> +out:
> +	return ret;
> +}
> +
> +/* Get current resolution from the host */
> +static int synthvid_get_supported_resolution(struct hv_device *hdev)
> +{
> +	struct fb_info *info =3D hv_get_drvdata(hdev);
> +	struct hvfb_par *par =3D info->par;
> +	struct synthvid_msg *msg =3D (struct synthvid_msg *)par->init_buf;
> +	int ret =3D 0;
> +	unsigned long t;
> +	u8 index;
> +	int i;
> +
> +	memset(msg, 0, sizeof(struct synthvid_msg));
> +	msg->vid_hdr.type =3D SYNTHVID_RESOLUTION_REQUEST;
> +	msg->vid_hdr.size =3D sizeof(struct synthvid_msg_hdr) +
> +		sizeof(struct synthvid_supported_resolution_req);
> +
> +	msg->resolution_req.maximum_resolution_count =3D
> +		SYNTHVID_MAX_RESOLUTION_COUNT;
> +	synthvid_send(hdev, msg);
> +
> +	t =3D wait_for_completion_timeout(&par->wait, VSP_TIMEOUT);
> +	if (!t) {
> +		pr_err("Time out on waiting resolution response\n");
> +			ret =3D -ETIMEDOUT;
> +			goto out;
> +	}
> +
> +	if (msg->resolution_resp.resolution_count =3D=3D 0) {
> +		pr_err("No supported resolutions\n");
> +		ret =3D -ENODEV;
> +		goto out;
> +	}
> +
> +	index =3D msg->resolution_resp.default_resolution_index;
> +	if (index >=3D msg->resolution_resp.resolution_count) {
> +		pr_err("Invalid resolution index: %d\n", index);
> +		ret =3D -ENODEV;
> +		goto out;
> +	}
> +
> +	for (i =3D 0; i < msg->resolution_resp.resolution_count; i++) {
> +		screen_width_max =3D max_t(unsigned int, screen_width_max,
> +		    msg->resolution_resp.supported_resolution[i].width);
> +		screen_height_max =3D max_t(unsigned int, screen_height_max,
> +		    msg->resolution_resp.supported_resolution[i].height);
> +	}
> +
> +	screen_width =3D
> +		msg->resolution_resp.supported_resolution[index].width;
> +	screen_height =3D
> +		msg->resolution_resp.supported_resolution[index].height;
>=20
>  out:
>  	return ret;
> @@ -448,11 +541,21 @@ static int synthvid_connect_vsp(struct hv_device *h=
dev)
>  	}
>=20
>  	/* Negotiate the protocol version with host */
> -	if (vmbus_proto_version =3D=3D VERSION_WS2008 ||
> -	    vmbus_proto_version =3D=3D VERSION_WIN7)
> +	switch (vmbus_proto_version) {
> +	case VERSION_WS2008:
> +	case VERSION_WIN7:
>  		ret =3D synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN7);
> -	else
> +		break;
> +	case VERSION_WIN8:
> +	case VERSION_WIN8_1:
>  		ret =3D synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN8);
> +		break;
> +	case VERSION_WIN10:

I wonder if this does the right thing on a system with VERSION_WIN10.  The =
existing
code would treat this like VERSION_WIN8.  Your commit message says that the=
 new
functionality of getting the resolution from the host came as part of RS5, =
and I suspect
there are host versions that report VERSION_WIN10 but that aren't RS5.  You=
 may have
already clarified this with the Hyper-V people, but if not, we should do so=
.  The
version negotiation here doesn't fallback to an earlier version if Hyper-V =
doesn't accept
what this code requests.  However, the more robust approach might be to imp=
lement
fallback on the SYNTHVID_VERSION setting.

> +	case VERSION_WIN10_V5:
> +	default:
> +		ret =3D synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN10);
> +		break;
> +	}
>=20

Michael
