Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD44316C1C
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Feb 2021 18:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhBJRJb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 Feb 2021 12:09:31 -0500
Received: from mail-eopbgr680110.outbound.protection.outlook.com ([40.107.68.110]:25159
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231481AbhBJRJa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 Feb 2021 12:09:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyymAolF5Fs1wgWbqV+LD327tfKseXFx35K+2xlAwA/Geo462KT3N7qWKnhdrGrQNW2R4WdMEGoXshLrpmccBJVq32kiVzlRA1y9GyZLh0M8VgjuOAD6SjrG5rMhfvIWzG6DmCGUugxNQMXJGF1xYoHe2ez/KioGLQ5BGfwSFLlhRSRtU1BrNDMWk87YKU/uGSI2lL0RoV4+Xvi2s3mZQSFdkPRtpxHhnkziu4Gu0aAzQq3FX03Nc6dKHLRSASGpK4FogSeOia4ZlYvwSpt8eRy7FJvXyBgDPaQYW98eRCPZ1tRVJHnMUxqa0UggrvW6wq1Ywb4VTbclHVf6CuD98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mj5e49leqFNeQDOJkzrdIQnd7WQFPmbZ1PIeQ8Y41ac=;
 b=oYyfUYolp33gR73bdEgOMw0h3bZ5j1wm2qY2/kfO8XN8Pt5fw80ZN82Az3RDLTpENqDmr6Rb3Qlc3l1NIylo/h33v8JTDoyhHuPtwQ8CXDl/VJs/og2XrK1driEAgmosWzqFGMRvYSvy7t/+oEvAA14osSZjuFKdgOe+5MAdIMi59YQI1h9cuSTt+9T5J6a+IwqZXID5sJPMKr8GNDfErpXLDe2VFVqOjknz2yqECiYwhQx5zqUKD+ZnLm0lrO/GerZOxvcRHPhv+ejZqAaSfQAvaa5lMuydOe8pwDRf4WlTHLpxT0GhGNHUt/5Y1aP6+IoJMazjxH/1cw8KfszLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mj5e49leqFNeQDOJkzrdIQnd7WQFPmbZ1PIeQ8Y41ac=;
 b=ffVhg9xqbchGZ5HNc+Je+lFeqHXkbskHgXAVAL7TvGOFL3McwTvJbUDaHViX6c8pDi9TOR0+BPoac0laly6zzs3PckZwCpyh7HQbKbFM9oFUhwx1Sq1kemOR/uWkViGayH0aR/ne5Z0+afGu6BZL7RSbdkB9v/B3bLrAyYdoKJk=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1772.namprd21.prod.outlook.com (2603:10b6:302:c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.0; Wed, 10 Feb
 2021 17:08:43 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3868.006; Wed, 10 Feb 2021
 17:08:43 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: Checking Hyper-V hypercall status
Thread-Topic: Checking Hyper-V hypercall status
Thread-Index: Adb/zOGyuLmPlhyMQS2mGAPIUNW8xg==
Date:   Wed, 10 Feb 2021 17:08:43 +0000
Message-ID: <MWHPR21MB15934013452AE9F2DF80C02DD78D9@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-10T17:08:41Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f123598b-2e67-4b50-848b-e1050b4eae47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fac717ef-9b18-465e-7b88-08d8cde6851b
x-ms-traffictypediagnostic: MW2PR2101MB1772:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB17727CCDF007C2F71761DAC8D78D9@MW2PR2101MB1772.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nR/2Dlt8+HJLq2DXWFZSSRPdxeZWzEhJ/Twoy6zCk43AtJ5uaiup1EQY122wnNz3PgDgKfNvoP2MH3GCnWFaa8ouINHA1TNu1n7TwRmWJZ56fmIHdqiKWDib+BSBk5IIGWpkjyipzbUz7t0czPiyasp1Jvgfd0QhPyHBlCxXMIFfUKgkT2Szs264ZcvqGuebokbi5Y8Nz2CZ6bOea550433cD6F0ycz9XhhlcY+PZRsnnddaS46jiZBDcmVcSxNZKZxhINk8dZyLv411yg/Ws7L8cRFnjxfl2q6PCHi0RszMy6pUzyWKpOvoJqnbmDaf1gIyX/tb4tEJM8Ij+VJD/YPcXWPyGtCyuG8R+IVXjayWu2KuEjfXUyCnlgQl+dbhyzJfhWUIChGKKXsx4CmLQisG7L4Yy2NKhn86ATsM6MubzbH1zDDahyQWVilm0YmtSxyEnpA/WI2RVPUuJIG515URLYzVo1fo3OrPlbtXrIANAwfH2ETPdr64kTsiz4aIRcaPr82xcBRJvEksEv1i7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(26005)(66446008)(8990500004)(478600001)(316002)(55016002)(82950400001)(82960400001)(76116006)(64756008)(5660300002)(66556008)(52536014)(9686003)(86362001)(71200400001)(8676002)(3480700007)(8936002)(6506007)(10290500003)(6916009)(2906002)(33656002)(66946007)(4326008)(66476007)(186003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6zESY5Sci64SN51XKtnSTjwuxQZnCE5YsCpccFcyDGp6bN5sxUJkNEaEndBM?=
 =?us-ascii?Q?wAz0J9yiIUvXv/NodbX/QSc0bg+FV+rOvfQlfccCOjDRDbqhDeQwJmHxXZmM?=
 =?us-ascii?Q?Q6UELZNQuV9mYIOkujD+Ih01aubV9i9/2BhWV58DHlCI8DcbpBu69SB2Ato4?=
 =?us-ascii?Q?1yuNTh6ZEk53NY5CfztI8GsHAB4jgqIUjBAflcoT2z64zjkghBAtuh+IMqJT?=
 =?us-ascii?Q?UJGlW2o1ACdNjki7UxOY9pvVCeP0m7DO2O4IDFpOlv8pHDS+fEYNRVeyNab9?=
 =?us-ascii?Q?LZg1tEsUE+m5rRM7TbYNE+G89Px9XiRCtJWEE8YbShx6WbgGSS3xBVs4ypMi?=
 =?us-ascii?Q?J6pUS1pgPHZoaW4R+x70x52M1gnyemmyUFpGfwIB3tm4FC2xgdcB2YkyjE8A?=
 =?us-ascii?Q?y0EXnhbkL5oWtLRal5k+K+Kcg+z0H9L2+/hzWkxo7PVAeey+GqQf3LdWYdE3?=
 =?us-ascii?Q?IuQVLk+3ywP8vLGfoCxDYTLY/HgpBgDOFUrNFpjRVPaZ+OaxzN3ZgFlkm4S+?=
 =?us-ascii?Q?1ySrJ4l3IIkFFgO4oLuxkUlzGem7bcjSFvWlv0i3y4LXvbfcX/e687tDFEci?=
 =?us-ascii?Q?4M6K2Drma1rFHeaNBvOHCclsBWdBuQVaFviTHwtuC+YU4buSXnnrd1nS5MWo?=
 =?us-ascii?Q?A9DGdcDwlr/p6JeobS0TyW7AJNAmpnizAme00zA50p7Ra/UErvXmu0gnCGgj?=
 =?us-ascii?Q?dIGtgTaUXP4B9Ja7f63rPtSHzKofXxc4qf157GgVT8vpJevE3zFlnzxS2xqB?=
 =?us-ascii?Q?4d5ZVHI/uCKedowcBG31VFAA/cqnkr7+GdpD9hHaQULAhMNEIozJRjyvz3B1?=
 =?us-ascii?Q?VmlWzphGWKpYZ6szkJ/7VUfgW25rN1mzlIm5CGuM4bCV4GfOQ484vf/Wd5Zj?=
 =?us-ascii?Q?BQEvnqLQwxoqAbZUWiEHyHvuOe+7vBKBrtuIbqjxDfJm80rmd2S4DwP4XCaq?=
 =?us-ascii?Q?CKDtwqDtnW5/NQGGlv1XqIfLAMGwyeDJd0K93+VlWOFboReqxrszOqCZvRjT?=
 =?us-ascii?Q?LL0mqXcrTx4NMJnmKg8g4yukE2qBPjXDJUfVMdO/QLAM2pmvEjWlVIJuQRio?=
 =?us-ascii?Q?eyGESAk4iZLJSmer4fFAbt50Ib0sjWhjohs1XakD6t1F1bGBza0/xl+pgrLu?=
 =?us-ascii?Q?D+So3M16G+xkeg0yxzVil+0v8wN6UMKaLHu0N86y9dl51JF9urpjfkv+VCn9?=
 =?us-ascii?Q?cVr4Z96VSHVV866VDlUfPslHp0HKuxm8WxnSee2v0YBK5bO2K8bJJhZiW5lo?=
 =?us-ascii?Q?o8Do8cos3WHDDcPmyC6CKTqHh9FMfv7NstM0sbn67oGUdoOmDNidP6ZA/gmR?=
 =?us-ascii?Q?K35q0+i4+iRzMZ5UZGJ+ZwbG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac717ef-9b18-465e-7b88-08d8cde6851b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 17:08:43.0699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUn9ZkTd5hmE150UiLOLdNbKnPjXcrRnFtukU9ZpPUG2n0xbmbayfp1XWD6LHvNVzZ1XiB1DnBZ1qjwTkbBdwjX7E7M1//Uu9M6EVKQCiDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1772
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, February 9, 202=
1 8:51 AM
>=20
> Michael Kelley <mikelley@microsoft.com> writes:
>=20
> > As noted in a previous email, we don't have a consistent
> > pattern for checking Hyper-V hypercall status.  Existing code and
> > recent new code uses a number of variants.  The variants work, but
> > a consistent pattern would improve the readability of the code, and
> > be more conformant to what the Hyper-V TLFS says about hypercall
> > status.  In particular, the 64 bit hypercall status contains fields tha=
t
> > the TLFS says should be ignored -- evidently they are not guaranteed
> > to be zero (though I've never seen otherwise).
> >
> > I'd propose the following helper functions to go in
> > asm-generic/mshyperv.h.  The function names are relatively short
> > for readability:
> >
> > static inline u64 hv_result(u64 status)
> > {
> > 	return status & HV_HYPERCALL_RESULT_MASK;
> > }
> >
> > static inline bool hv_result_success(u64 status)
> > {
> > 	return hv_result(status) =3D=3D HV_STATUS_SUCCESS;
> > }
> >
> > static inline unsigned int hv_repcomp(u64 status)
> > {
> > 	return (status & HV_HYPERCALL_REP_COMP_MASK) >>
> > 			HV_HYPERCALL_REP_COMP_OFFSET;
> > }
> >
> > The hv_do_hypercall() function (and its 'rep' and 'fast' variants) shou=
ld
> > always assign the result to a u64 local variable, which is the return
> > type of the functions.  Then the above functions can act on that local
> > variable.  Here are some examples:
> >
> > 	u64		status;
> > 	unsigned int	completed;
> >
> > 	status =3D hv_do_hypercall(<some args>);
> > 	if (!hv_result_success(status)) {
> > 		<handle error case>
> > 	}
> >
> > 	status =3D hv_do_rep_hypercall(<some args>);
> > 	if (hv_result(status) =3D=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> > 		<deposit more memory pages>
> > 		goto retry;
> > 	} else if (!hv_result_success(status)) {
> > 		<handle error case>
> > 	}
> > 	completed =3D hv_repcomp(status);
> >
> >
> > Thoughts?
>=20
> Personally, I like it and think it's going to be sufficient.
>=20
> Alternatively, I can suggest we introduce something like
>=20
> struct hv_result {
> 	u64 status:16;
> 	u64 rsvd1:16;
> 	u64 reps_comp:12;
> 	u64 rsvd1:20;
> };
>=20
> and make hv_do_rep_hypercall() return it. So the code above will look
> like:
>=20
> 	struct hv_result result;
>=20
> 	result =3D hv_do_rep_hypercall(<some args>);
>         if (result.status) =3D=3D HV_STATUS_INSUFFICIENT_MEMORY) {
>                 <deposit more memory pages>
>                 goto retry;
>         } else if (result.status !=3D HV_STATUS_SUCCESS) {
>                 <handle error case>
>         }
>         completed =3D result.reps_comp;
>=20
> --

Your proposal is OK with me as well, though one downside is that it is
not compatible with current code.  The return type of hv_do_hypercall()
and friends would change, so we would have to change all occurrences
in a single patch.  With the helper functions, changing the code to use
them can be done incrementally.

Back when I was first working on the patches for Linux on ARM64 on
Hyper-V, I went down the path of defining a structure for the hypercall
result, but ended up abandoning it, probably because of the compatibility
issue.

But either works and is OK with me.

Michael
