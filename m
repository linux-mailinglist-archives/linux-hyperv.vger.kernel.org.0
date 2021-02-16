Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005CA31CBDB
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Feb 2021 15:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhBPO0k (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Feb 2021 09:26:40 -0500
Received: from mail-dm6nam10on2137.outbound.protection.outlook.com ([40.107.93.137]:24736
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230190AbhBPO0h (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Feb 2021 09:26:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg8IukMA/F+GrJbWTXLZvXgPPaLZkSb0NbNHdqL3wUkC2XJbXTqEYzl8XPwed82qZA8fVzq2WGYl0+BFn86hWz4veyE7DBhYybGY/TZIOOupH437e2YWaYmvOfN2jeJFc5pyLvbSv35Dn5fBQQ27t6vVNGv3nTYcDAPC96W+h4QHXCE76UHUfWmlUOf0jgV6WZTMxB6tkCYLlsqiNRoSdhgayWXsMiGakhl5zudTMEAuNn1npWSt8faF3RWosMam5y6lm0m/uw+HJ8VcvrTrh/rhdxwpgevNJIwK/eiWK0+t5pF0DHpf+iOTQwaogsYlhwc74oVWidvKOaSe0SApww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUqR8FCBpSntm/PNv743V4BPSHCVfotuXcopWLjjkM8=;
 b=PzIk9Lsx59PDcNKhOi1PYWhb4aKhLfOeWCvI+e5I1nTcA42PH7A/Ur20LiQ7+kxYXkFM8vg6AaCcatI1B4xh0d2OMbixK/etdjLZCQHtB5ngI7xiyqAw0OfN13l6TE39mUQYd0sGVQd+nJfKGxZ/ZIwaIh3LaFkGdQqIjKF1cjj746OlUom6dn4G/k8x+sdBfkBZIflo57CWgDId8qWl8fkJ3E7e4XRV17nyKxEkW1UVcms0rgNHIKapKpS19raxsEsVkTobF7x1dUQ4PmNUDjRpxs0vLT3ZZKQoR2rEEsiA7UD2aX+fzfQZfYWTuyvV48Q/XSHALTVIf1zw+5Y+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUqR8FCBpSntm/PNv743V4BPSHCVfotuXcopWLjjkM8=;
 b=G90I7NY7cN0+/bVErwWueA/ZT2zbiNCPxarZxbYZXwutB0wothaZ/oLqA2ck8Jm3A1uhiigdClgJDO9z2DVVQLyw4RQb4h2e5ml+0S/Q+xnNeCEWqBN64uUuM6QSCz1hxElEAJvWi3//GHewxqXokl7H4DwPEcAuX61/PnxSILo=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1956.namprd21.prod.outlook.com (2603:10b6:303:7a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.3; Tue, 16 Feb 2021 14:25:43 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3890.003; Tue, 16 Feb 2021
 14:25:42 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: Checking Hyper-V hypercall status
Thread-Topic: Checking Hyper-V hypercall status
Thread-Index: Adb/zOGyuLmPlhyMQS2mGAPIUNW8xgEohqsA
Date:   Tue, 16 Feb 2021 14:25:42 +0000
Message-ID: <MWHPR21MB15932A447B6A9AAE21AE4119D7879@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <MWHPR21MB15934013452AE9F2DF80C02DD78D9@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB15934013452AE9F2DF80C02DD78D9@MWHPR21MB1593.namprd21.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: b764214c-12c2-48a6-6220-08d8d286be10
x-ms-traffictypediagnostic: MW4PR21MB1956:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB1956EC4959E7FF3D685F407FD7879@MW4PR21MB1956.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PxChSEZJ8UNVyKibltBNyEaXzrrQPkKQOgW1vPaULYLAqLHzsYhhpSrNO2WhtMF50zCJ9COLIWW5jnjKvqIcxL9yoJG8HHaVlxbq+X/baNog2ggGwM1QZ7sV4kdks/d1ShG7H5AtF4UrKEXcTUughd4LcvWcasecn5gwd2WqjfH6mGksDOvMy+VQnHByFC45gjpum4dLliyzgB+dd86KPJu2qctV2BMqBjJGzord5F59xzGwlDfFhMNq8hhm0ouRNYxMK4jIfc1e3N1GMlnHN1IGyxI1/mRsKrJPp61tQXH0QvffP+/IOnYSum4KQpdfHtBfLX2V9EKd8B8lGYufut95Y0p2HsfnuOBChtI/8jhNu//Xa1ljorcZhsUBhz+0/aVZqLmJenQu5GTEP+MAk87QiIrBt0Cujj/BIqLRWw7AqXZMJlNm+rcKAJWNJ3LTTID9Tcl+ROZ1ZCcQU3wFWYp8UyxrMOnzzUeSKHsEW87quHHXZaB+75cTwiCJ1Mtzv8BT5VC9JcTfrY3dj+7y7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(52536014)(66556008)(33656002)(66446008)(71200400001)(5660300002)(9686003)(8676002)(2906002)(4326008)(3480700007)(10290500003)(26005)(76116006)(8936002)(8990500004)(82960400001)(186003)(66946007)(82950400001)(316002)(478600001)(86362001)(6506007)(83380400001)(6916009)(66476007)(7696005)(64756008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2nN7XF0HcXtsQ78+lvgWJNcg1Qh9CfoQ0/Wv2dh+BOIqXJixgivNfb3Z5/7Y?=
 =?us-ascii?Q?AOPUxT8YfG3+w4fE6ar8P2jLN2eAloGxw+dyu4RgkojHSNoTZ2ER7W6C7IHU?=
 =?us-ascii?Q?sFHermymqEpfU7RPUvukVrj4Z6ZJLPfVhhHeXLznlUe/8jKBHL6nGeeLcI/y?=
 =?us-ascii?Q?XmB4oCh8cDkXdhL/UpBFXxxEYLZ6DbaXW62zNRjeLnkq6co3J09pzbhwBAhJ?=
 =?us-ascii?Q?WlZppDC/dZPtR4KO1w463/iuLxmirU9lIjb0YinwZDlbf2sUGCU/WO0AM9X4?=
 =?us-ascii?Q?IByFkA2WEWds77ixRinD37v3Luhy9KdY3OtQNxjgHM1Kx5HEAJQ00GxhPfFY?=
 =?us-ascii?Q?P1nKxTPUAKZ/FXu/9Y219U7HLzUzeNxEWwBy/kcKmmCJIuKdGoVpqCUIVUwb?=
 =?us-ascii?Q?FQ8lLvqyEEnmdISzTYIy7+Vqnic3fqZ03BlUdU0uPAekBjmLF0yw2hSdxMX1?=
 =?us-ascii?Q?UaTtn8w3xRjt1U+NJ3V5UgAoKJN5ee+GqWHrcUffxH7sDmDapr/jFDr/Gvc8?=
 =?us-ascii?Q?yo9y2W0YMuwANyhb0YVJMu8QDhMChsqoVawJLRlHxSCfqHxh9+1s2y6nvu5y?=
 =?us-ascii?Q?q4LcY3Bcc24Nudrhq+EdDt70GD4amqW5aKM1W+bEkhwwyQ0jzI5E6aZRYI8Z?=
 =?us-ascii?Q?vdpzlEMY3oaS7jVWSYhQgSRriUty8lH4U8qNRCx0EmhdE03ubozNF4IUoCBe?=
 =?us-ascii?Q?ZOhlZPV4lC3hky+jF3lqjP87XhK3yDk2YpNYkI4t5PP9ax2t7pZHF7rTQBPC?=
 =?us-ascii?Q?8RC870TkTNhriGqUsGmpnr+VXH8DfRFJzhYUheDr/p4ifWvsNAJV9inIC/+s?=
 =?us-ascii?Q?VdIkyxBYDPWieqEqc79pTyRaam8gxF9ZKOq2DXVMLLOjhi4/Ge89PhlLNpVJ?=
 =?us-ascii?Q?pgqK9G+V8ROgG3Y+L6GyesDx3FSzcb2/1QqBxTtEi+5G1ozTpBGz8kmzQaFo?=
 =?us-ascii?Q?5eKdoaQFd2zCaaaq4+579CBNz+8TuHEpRcksz8L6Q3Js5eJjxnzym9Mp+src?=
 =?us-ascii?Q?Fn6K/jlu6KZgQX1l3qCzOA8ehGGXKsoDjJGU3X7y4eYWyGZ/Y5TEPoNu/O+p?=
 =?us-ascii?Q?INXZnh1ES9StTOgxMIsNeMNMUg2ewS+395LEqgooyMjYikyHJNQf6WCl5wKq?=
 =?us-ascii?Q?yoASY1M65L7Cwb0Ip9mMeT4nFtf9P8SGihPEyMtO+VPw7aj1X+7hVJj7ZWSV?=
 =?us-ascii?Q?gEGpu+8n/l4INB4rlVzergeWaF9TO1Y0SkBx8pb516Y8yu/Wr6IFGYE2CkRm?=
 =?us-ascii?Q?IaZE4utrmZx8CsHBZZSe/9dd1mdrvRTVW5UzYWv1NmwIDQlL4oXexT6+aojH?=
 =?us-ascii?Q?VNQrWcT0TmLtCMuxOnDu7Mm/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b764214c-12c2-48a6-6220-08d8d286be10
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 14:25:42.7851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpMjW04luX30yiJTebBUeNltxWhTtxZa0unx0TbJNS+xZAm6WmL/kuJD/8AthU2vgrMTj/KxNMwMWSXTKjCntwaWoqy4ExtkX0kEBSBT1Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1956
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley  Sent: Wednesday, February 10, 2021 9:09 AM
>=20
> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, February 9, 2=
021 8:51 AM
> >
> > Michael Kelley <mikelley@microsoft.com> writes:
> >
> > > As noted in a previous email, we don't have a consistent
> > > pattern for checking Hyper-V hypercall status.  Existing code and
> > > recent new code uses a number of variants.  The variants work, but
> > > a consistent pattern would improve the readability of the code, and
> > > be more conformant to what the Hyper-V TLFS says about hypercall
> > > status.  In particular, the 64 bit hypercall status contains fields t=
hat
> > > the TLFS says should be ignored -- evidently they are not guaranteed
> > > to be zero (though I've never seen otherwise).
> > >
> > > I'd propose the following helper functions to go in
> > > asm-generic/mshyperv.h.  The function names are relatively short
> > > for readability:
> > >
> > > static inline u64 hv_result(u64 status)
> > > {
> > > 	return status & HV_HYPERCALL_RESULT_MASK;
> > > }
> > >
> > > static inline bool hv_result_success(u64 status)
> > > {
> > > 	return hv_result(status) =3D=3D HV_STATUS_SUCCESS;
> > > }
> > >
> > > static inline unsigned int hv_repcomp(u64 status)
> > > {
> > > 	return (status & HV_HYPERCALL_REP_COMP_MASK) >>
> > > 			HV_HYPERCALL_REP_COMP_OFFSET;
> > > }
> > >
> > > The hv_do_hypercall() function (and its 'rep' and 'fast' variants) sh=
ould
> > > always assign the result to a u64 local variable, which is the return
> > > type of the functions.  Then the above functions can act on that loca=
l
> > > variable.  Here are some examples:
> > >
> > > 	u64		status;
> > > 	unsigned int	completed;
> > >
> > > 	status =3D hv_do_hypercall(<some args>);
> > > 	if (!hv_result_success(status)) {
> > > 		<handle error case>
> > > 	}
> > >
> > > 	status =3D hv_do_rep_hypercall(<some args>);
> > > 	if (hv_result(status) =3D=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> > > 		<deposit more memory pages>
> > > 		goto retry;
> > > 	} else if (!hv_result_success(status)) {
> > > 		<handle error case>
> > > 	}
> > > 	completed =3D hv_repcomp(status);
> > >
> > >
> > > Thoughts?
> >
> > Personally, I like it and think it's going to be sufficient.
> >
> > Alternatively, I can suggest we introduce something like
> >
> > struct hv_result {
> > 	u64 status:16;
> > 	u64 rsvd1:16;
> > 	u64 reps_comp:12;
> > 	u64 rsvd1:20;
> > };
> >
> > and make hv_do_rep_hypercall() return it. So the code above will look
> > like:
> >
> > 	struct hv_result result;
> >
> > 	result =3D hv_do_rep_hypercall(<some args>);
> >         if (result.status) =3D=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> >                 <deposit more memory pages>
> >                 goto retry;
> >         } else if (result.status !=3D HV_STATUS_SUCCESS) {
> >                 <handle error case>
> >         }
> >         completed =3D result.reps_comp;
> >
> > --
>=20
> Your proposal is OK with me as well, though one downside is that it is
> not compatible with current code.  The return type of hv_do_hypercall()
> and friends would change, so we would have to change all occurrences
> in a single patch.  With the helper functions, changing the code to use
> them can be done incrementally.
>=20
> Back when I was first working on the patches for Linux on ARM64 on
> Hyper-V, I went down the path of defining a structure for the hypercall
> result, but ended up abandoning it, probably because of the compatibility
> issue.
>=20
> But either works and is OK with me.
>=20

In thinking about this a few more days, having the hv_do_hypercall()
functions return a struct rather than a scalar value seems a bit off
the beaten path, even if the struct is a 64 bit quantity.  I just wonder
if currently unknown problems might arise later with other tooling
(like sparse) in using that approach.  So I'm leaning toward the
helper function approach instead of bit fields in a struct.

Michael
