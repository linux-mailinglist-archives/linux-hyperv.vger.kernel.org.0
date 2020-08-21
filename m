Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4825124D900
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgHUPpm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Aug 2020 11:45:42 -0400
Received: from mail-dm6nam11on2100.outbound.protection.outlook.com ([40.107.223.100]:20321
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbgHUPpl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Aug 2020 11:45:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkhEEDTeZRT9QS1RyaQ49PUCrNv14g8ImZJyI1V9Wy3k/xEiEjHh8464FmYSt32SV9U4cMjEZGCyeDsS6J+EPLwkWDp89Onlsr/aE8uDVk/yDjX030mWxwek5XiTO2NhW1gJUDpAXwuj3bEXi7AJoZS+55hwZUmh43AGDpcVf/ePhajy2/xfuBSrzQXQKTqNvzBHCT4uZ1L9bAB2nAmZHPLyvydvmKMhOcwjBQ+jyEVM0jadvK3teywl5Ad5Nu5buDyWKMhDyQ2ykT9IiwRt/SxAdIl3CxambLEMqCXs6EDjG6EFj+n5r6gUGHCtAFbVhgi4rGrKlcEJ3FZpbwFRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0ejjOk18+N+7QCXAqYxlzLriK5fvHkZ5rMabb4wmRg=;
 b=oH2f+5eis21ZbqEygD1Ov+BzR2sPHnE5yPdoHbUOE7BNW+zbZ17QPkU4Bdc4atneLAhBKsk3b4iUf5S/PLHzPOxxqZpj6d9yOx4ph7jyrblRffUMfpS9XbvzzSrwFMUxb8HDtcykeY3qmfc0OWpZkyFrGz+c2actSrCZuDxhPXTN9LQWgML3Sn3p0IuQTvrqGEYzFr46HeVCG+v0B7yETMX7xeGDKr0OaJCzqO0WlxpraY8+pmdRx+5EKPhKE7MJVudw17A+xQ5jAZ4r1eiB9AApqLG7ZL4ls8kLta+u1uGvN4dQpa3GOP44lshWemnvK8gaAvA8s+14ij5N/giqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0ejjOk18+N+7QCXAqYxlzLriK5fvHkZ5rMabb4wmRg=;
 b=an3zsBPEkWXCcAk3F+164dKXV1himdhiV4IbycxDB2VmSFn+8O5+u3UvtS8UdguVC4A5uT6JjEe7mtvW2k0zM8F3dvXLvFSJpxPMh3pu0fPRGMzB0F2b0/iG4V6Z1ZCP5PqSIFWFLB1Grq6JA3ygFjMO9NT62OelNv+nv0j+6jY=
Received: from SN6PR2101MB1056.namprd21.prod.outlook.com (2603:10b6:805:6::17)
 by SN4PR2101MB0879.namprd21.prod.outlook.com (2603:10b6:803:51::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.8; Fri, 21 Aug
 2020 15:45:38 +0000
Received: from SN6PR2101MB1056.namprd21.prod.outlook.com
 ([fe80::b8fd:8dac:8dbc:56fb]) by SN6PR2101MB1056.namprd21.prod.outlook.com
 ([fe80::b8fd:8dac:8dbc:56fb%7]) with mapi id 15.20.3326.002; Fri, 21 Aug 2020
 15:45:38 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] hv_utils: drain the timesync packets on
 onchannelcallback
Thread-Topic: [PATCH v2] hv_utils: drain the timesync packets on
 onchannelcallback
Thread-Index: AQHWd8/6M2ElbkS+5E62FizkrLVASqlCtEYA
Date:   Fri, 21 Aug 2020 15:45:38 +0000
Message-ID: <SN6PR2101MB10564E82C6F9628D8745FA84D75B0@SN6PR2101MB1056.namprd21.prod.outlook.com>
References: <20200821152849.99517-1-viremana@linux.microsoft.com>
In-Reply-To: <20200821152849.99517-1-viremana@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-08-21T15:45:36Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=641b905d-9337-4b4c-8000-7fbd81e843eb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c0fea56-4fe6-452f-7c80-08d845e9407d
x-ms-traffictypediagnostic: SN4PR2101MB0879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR2101MB0879B4AE5C1C50506B6503DBD75B0@SN4PR2101MB0879.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8W4BL4oIZnCG+rbs6jKBPCUcIjwOSIUAGf4Hj9+4CaXKW3vkGAcysF38Xx1rTlvfyBZf0wzynh+4xpEhUSNLXuFZCFJnYJQESTaEJms9GHchc1ypP2ty8wW9nV5Uaj6splE1oNNGkaA4JsbYGlxIBt70A+LeVZdoiPxLCKh2nt4/zQOdJUE9FOtmwXlJ5shF+weVFjyQ6KBetCKaEHmWEzkg/gjdMKTtZU4tjt0o7JB0XCjkbBqmFHuLVGKs/9L6tK441sF86Q+mC6PefJNHFdZcy+r1GWavSy3mexf2ASdYQVuSDWUgGfPPrRJjlFuE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1056.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(110136005)(7696005)(316002)(478600001)(5660300002)(8676002)(8936002)(4744005)(71200400001)(54906003)(6506007)(86362001)(52536014)(55016002)(186003)(66446008)(82950400001)(83380400001)(64756008)(2906002)(33656002)(4326008)(9686003)(26005)(82960400001)(10290500003)(66946007)(66556008)(66476007)(8990500004)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: z3XOcgezIuWOribw3GO1AHu/IPlKLAD2gN2HRSCZ9p+AMplmXh2GEHocAbGkMapMblE5QeO+G+NaCZ74KjBv9TfSanL7BLvbj5y/ROUW01TRks5AJqZ0XIoqUX6NrSHjmUyJi5gFIQzafX4pnMbcdqkFwevMBTCO8NjIjqceduww+GHeCtkNvlWhEnuK+EKR/d46TrgX3kKeTrVux+e/+5ENFas0Dw0hf0toC2Kv6D8M88UXCPsn3GNSBgpEy1pwF/cWSpuDI86WC18AI5n2U3BdSQJVn0WYf74XxcnuVisutdLZjT2R0Mv5fqeSqY0SqYv3/b8cywVPHJ9RVn3dvPcxOqgMaaHvQ+H1jLxhGIQNdLFL1KYygXRm5GaEvdM7IpB5wIcuN8jbC5A9LRlrDRAdz1LCQkVG2XRQA8YPC8xt8CWMinsZrig6qKDkeoHG/lz8QTogoAGZdp+2aceda2U9jvOq/yaRlsH8WsBJDW0Cu2ISsRJSypI67Br6TDN1zv6WHtpdN2CPXRzlds+JfOD/NmDEH93oMu047FhFk7Pe/4rQeHRDRJ0LCJ0z2DhUXautpGOyxuKJU314PJOpCZH61JAhmtcadn4UCWNly1GTTYNfbOzTLOQTKepZCsY3HxOEIBSSDW7MeqQlcLWclg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1056.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0fea56-4fe6-452f-7c80-08d845e9407d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 15:45:38.3388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5oxP8KHwJknIyu3HiolT5WeMiL8JDmd+96BwbtbhaiGKbyD6mRWvWVw+Py4Oa4Xp747wADKUvzFVnxPLOA12+kj1BA2193Do+CxqAkhiRWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0879
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: viremana@linux.microsoft.com Sent: Friday, August 21, 2020 8:29 AM
>=20
> There could be instances where a system stall prevents the timesync
> packaets to be consumed. And this might lead to more than one packet
> pending in the ring buffer. Current code empties one packet per callback
> and it might be a stale one. So drain all the packets from ring buffer
> on each callback.
>=20
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> ---
>=20
>  v2:
>     - s/pr_warn/pr_warn_once/
>=20
> ---
>  drivers/hv/hv_util.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
