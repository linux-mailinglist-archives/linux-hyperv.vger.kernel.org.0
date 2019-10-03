Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0BCCB22E
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2019 01:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfJCXPm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Oct 2019 19:15:42 -0400
Received: from mail-eopbgr720112.outbound.protection.outlook.com ([40.107.72.112]:39779
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727452AbfJCXPm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Oct 2019 19:15:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D98oGlwfDaAAAWho+FJXzifbicXDYRRfmsUv+W4A+aQO4WRy1mV+2+kli9XHal37+ZWAJGdyfH+S6MrLf3pBvFFMxJ1puo2z0xKxrseqTUCHdoguQ8nIuuzAAoJI99uzh2xW/Pra7wwcIGnb+iRJbBpupjI5ga+j9x5wh0onr9NyxNNdBrdMJdhrvfdfVnECOpJeBsKLAShe9zrqMZTM7I3gIPOl/2cZYC56w/lJCte4xOYoNLoAPjNFO/Z1AU+xPbKdP3TSCFV8sX/mO7gUWzOE0Kbh7fOTXGkJlv23nrQrtNIe2A3dzYCN2v3gVAJt0F9gmGxCn9YcTZQvYIatwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFyZ0txkBQ6NR7kMT3u5xZJ6+YwZoez3T3THaxKTBjQ=;
 b=UnfnW4gMbqgAnYFKMNkcpmf+Yd8sLXnRja+Q1r0KYQr/n6ASmHrQJ4UIsMSxL/YxgsSr1m/4ompmOVdM7CWIZG5nu3zs6b/9xwRA473PCajKoeiLu13nIc38eoxV1uHXVSNJC9auVJXCEoQmkogJBdBgIen51DeVFggkoP6OTSL+vgikM3uKD6kwhFTQ17Dh3bqH/i79MXnlSKj+xmkjuNgbZOViAbgCBTCmlU9ywupghRHHMJ6UtBQZexmRljBz0RUVojMNSaY1XZhYCp9l9SXf6weHZu32Tc1EeHT/jBUQmqEe5iUMBFrhBeyldrTckXo84l8eo2QzYBrQfanruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFyZ0txkBQ6NR7kMT3u5xZJ6+YwZoez3T3THaxKTBjQ=;
 b=OCbwbBH8Lbk8GZfiCSRTF5l/7RNxUIP5ihULKIcyp5zVZCsW6XBX3U41DjqnK3jgbvdPd4aaYvqDWYRYH1VTApju27HRoEajBZLqLYLXpgSHMudU0Y7jmFjI5KtM2th7x+PznN39abcd8hb/IEPp0TZCfjIaX8K6pwbp4cfVX0o=
Received: from CY4PR21MB0136.namprd21.prod.outlook.com (10.173.189.18) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.8; Thu, 3 Oct 2019 23:15:40 +0000
Received: from CY4PR21MB0136.namprd21.prod.outlook.com
 ([fe80::a849:fd6f:615d:64e9]) by CY4PR21MB0136.namprd21.prod.outlook.com
 ([fe80::a849:fd6f:615d:64e9%10]) with mapi id 15.20.2327.009; Thu, 3 Oct 2019
 23:15:40 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH 1/2] x86/hyperv: Allow guests to enable InvariantTSC
Thread-Topic: [PATCH 1/2] x86/hyperv: Allow guests to enable InvariantTSC
Thread-Index: AQHVegKONOQa53Lxu0KKenjrGuzu3adJjEvw
Date:   Thu, 3 Oct 2019 23:15:39 +0000
Message-ID: <CY4PR21MB01366C1E5858DA8BBDA3886AD79F0@CY4PR21MB0136.namprd21.prod.outlook.com>
References: <20191003155200.22022-1-parri.andrea@gmail.com>
In-Reply-To: <20191003155200.22022-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-03T23:15:37.9996390Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7e10b395-64ac-4c3b-8ac8-cb0ae0776f17;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fee20eef-17e5-4624-46ad-08d748579b44
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CY4PR21MB0696:|CY4PR21MB0696:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB0696FB6673244BB761EB80E5D79F0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(22452003)(4326008)(2201001)(186003)(71190400001)(2906002)(9686003)(7696005)(7736002)(76116006)(8936002)(229853002)(8990500004)(55016002)(86362001)(81166006)(8676002)(81156014)(66066001)(6246003)(6116002)(33656002)(26005)(99286004)(71200400001)(446003)(66946007)(66476007)(64756008)(6436002)(66446008)(476003)(11346002)(66556008)(486006)(256004)(14444005)(54906003)(10290500003)(74316002)(52536014)(6506007)(478600001)(4744005)(10090500001)(5660300002)(102836004)(14454004)(305945005)(110136005)(76176011)(2501003)(316002)(25786009)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0136.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E3ujCQ4ExFR2BHdi4Ercn2ZhrRkEuyAd8cgZxDPjHRac7avLMP8pk7MBYjrBRLo14o3iR0tnaSvGHLJW0aMyLIVmDGTjo/FqNm4YGkG+Yaf+UVQOHkqweRnkt2JctxTXGzcilGM3Bnpd+K5denPhep+hzS0oBjxwChrhk+Rv4GaoJsYcKJeXhvTqmNHueat8V8zC0L17mJFa0UY9U0ECsRCYq78t6y1ujWVzXtEGwqrAtnwACRMKdRzdlTbyXY7YZlkrIWqIgk+SXowi/Gscre+9U4DR9/LdRzHqXI4zoHkx8QVi++xEW4/y5O6U/aJL+pLtXlcg50G9JWZ7JpajwMe+tc4mLenAj8rFzMI0org1fNbcPzkq5YV+DcU0Uaqr49WTYRN8kbhEu9u8lWubDpVLk6sQ7uYFxQNJI3EzXZo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee20eef-17e5-4624-46ad-08d748579b44
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 23:15:39.7673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oWdB1+qf6ZeYCwINBOsqjUvBA2Z31TOpk4V36VxBmfXZx09t1h8QSXfQz6Ne2gw8B8TTgzPxeiK2PHWzo+Quckq4Da8x0Dp5QvypYHvxcG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com> Sent: Thursday, October 3, 2019=
 8:52 AM
>=20
> If the hardware supports TSC scaling, Hyper-V will set bit 15 of the
> HV_PARTITION_PRIVILEGE_MASK in guest VMs with a compatible Hyper-V
> configuration version.  Bit 15 corresponds to the
> AccessTscInvariantControls privilege.  If this privilege bit is set,
> guests can access the HvSyntheticInvariantTscControl MSR: guests can
> set bit 0 of this synthetic MSR to enable the InvariantTSC feature.
> After setting the synthetic MSR, CPUID will enumerate support for
> InvariantTSC.
>=20
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 5 +++++
>  arch/x86/kernel/cpu/mshyperv.c     | 7 ++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>=20

As noted in a separate email, this patch is standalone, not 1 of 2 as
indicated in the subject line.  Modulo that,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
