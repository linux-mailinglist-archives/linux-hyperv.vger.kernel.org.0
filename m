Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB6BA5EAA
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfICAoX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:44:23 -0400
Received: from mail-eopbgr1320111.outbound.protection.outlook.com ([40.107.132.111]:29696
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbfICAoX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:44:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArbHe50S4Vr8B4wT3uIPfWCGt4j4Ad1M04ZLvQnnBU0Ao72yVYjDXcErlY8nduP+NhkGYgjnAOQQMTgdmntAEIOkvd8rPLPOVI3LZwn3zUWaPGuHk+i+fw56kUEmYOtH8M7ES91auOOEtRFo82z7J0zJpM+h9wIh2KKpDOPkvRFTTQXEh5MSbp7t4dFPAjZ0JRVGRRouVOmndOlnx9n+7Oosnbzhcng9hx6d0JqtphpWTUaRx06JYQq1Ue/7S1VlpNIRTAv/JYrksjRtByOcudTokkL16uPzdrw8ObUwC4Tk1E+zspMLqfc96xjjrGczFDMIm/wTlyDndaOd/AjLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Gp4xZa5YZqfTKo1yFa41UVsRDpK3VnnxGrhdHYz+FA=;
 b=Hp2jp87yj+zt1vqXe9aKSrXBrIU8ati5ER6MUkumfGqkM01K6HHPyGkSHJDwT4TkY+iHbnW/n34s2uYAogfpPXBE1yrV0Y+Q/FgjVqJZkTN2gPlxQHRmDQovy7rzjNQScvPOGeOVTp7xQMfcBvWC/AfJgCjkKb/bjhZjPN94oZidUgrdj+zAJBu4pCrPrqhyKrClVtWRfMgcr8lWJWQWHiX9dj5zS8RguU2vgsd9ucp8doZk/7uDUb8zXFGVI9qPomSRgpCu924Z7OsmFNfZKEkfiMnFG0To63wDNa1AyWdWZ5VXx5/n4DnjKFyq9MgVw/kd1KlmK/G5mvaOkWFuIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Gp4xZa5YZqfTKo1yFa41UVsRDpK3VnnxGrhdHYz+FA=;
 b=e2miUOdeo1YBYIv3wIHpMRTajDktFv+ZUC1nUrOHLbKoXK53xELB8Ahec0Ej9WKaJ9Nc3IEaScaNjSSnJXlcZxbmi9HJsVIWU1G4yp8zAoe7amypOSGEtxL5C8RBJbtSnTG7ujOdBIYlKRR8ViM8Gz1oFAACWcj0ub/U4+VRbKg=
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM (10.170.173.13) by
 KU1P153MB0102.APCP153.PROD.OUTLOOK.COM (10.170.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Tue, 3 Sep 2019 00:43:34 +0000
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::f112:af3b:a908:db07]) by KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::f112:af3b:a908:db07%7]) with mapi id 15.20.2263.004; Tue, 3 Sep 2019
 00:43:34 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HID: hyperv: Use in-place iterator API in the channel
 callback
Thread-Topic: [PATCH] HID: hyperv: Use in-place iterator API in the channel
 callback
Thread-Index: AQHVVwLgob1PhqdeUUavARficZPulKcZMP9g
Date:   Tue, 3 Sep 2019 00:43:34 +0000
Message-ID: <KU1P153MB016679060F4360071B751AF0BFB90@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
References: <1566269763-26817-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1566269763-26817-1-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-03T00:43:32.5400913Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d6c1cfa4-0a65-45d4-9173-db23b947dd6a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:45b3:904b:db76:f1a7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: feed42de-0e11-4f88-acf7-08d73007c079
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:KU1P153MB0102;
x-ms-traffictypediagnostic: KU1P153MB0102:|KU1P153MB0102:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <KU1P153MB0102E5436D330735CF11FC09BFB90@KU1P153MB0102.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(199004)(189003)(13464003)(6636002)(6116002)(186003)(316002)(22452003)(14454004)(54906003)(74316002)(229853002)(5660300002)(4326008)(2906002)(110136005)(99286004)(256004)(10290500003)(7696005)(33656002)(71190400001)(71200400001)(76176011)(102836004)(966005)(8990500004)(25786009)(6506007)(53546011)(2501003)(478600001)(6246003)(76116006)(8676002)(66946007)(81156014)(81166006)(2201001)(486006)(8936002)(476003)(446003)(86362001)(305945005)(11346002)(53936002)(6306002)(10090500001)(9686003)(55016002)(64756008)(66446008)(7736002)(1511001)(66476007)(52536014)(66556008)(46003)(6436002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0102;H:KU1P153MB0166.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V2k6fRdnSU+/Ey8ThSCCcC0gF3ExUnZGTGPa2ZyIZ2gss0kW53sXUMBAc7vhFxbq9IbiPXjp+ril/s8Yhf2Ad1DtN/AKwTNSZiAWfZUC6nmExbBbhw5nS9t2n0oH53rut2rRTq5XwlItL+2tmeNE/OlGYaUxHLwljN6RlI0WUd+wXHWUMKdvT5V0tkr3z2Z+di3n/8pfNpbY8dNkA6pMa1FBfdpNXb/dnV5UMxumISbKAfe2K3NmuHJBcxV2dE1E/FYkl94BgDZyCTnlqeWNS6CBkOrPXXeAPgDRiWxRShAoVz5mCdMTM4siUUIhxh4dOmlAye49L4VrHNZikBIVhtSK9ZZT5+JKX7IyQ0Voj/O/RSvwO+U+cSBWUSArdbyQ0ygGzS2QF/XeQrB+aPLmhCM2t3FWuh3X+0ACgMS+kGM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feed42de-0e11-4f88-acf7-08d73007c079
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:43:34.3641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5joTboeHBVxDiIQm8m0iwCbt84pRvymOnwoSxdNp4StQzhBF/fd9Eo8Hap0HIzsVdIeBoSpq+idOM9A6aXijg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0102
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> -----Original Message-----
> From: Dexuan Cui <decui@microsoft.com>
> Sent: Monday, August 19, 2019 7:57 PM
> To: jikos@kernel.org; benjamin.tissoires@redhat.com;
> linux-input@vger.kernel.org; linux-hyperv@vger.kernel.org; Stephen
> Hemminger <sthemmin@microsoft.com>; Sasha Levin
> <Alexander.Levin@microsoft.com>; sashal@kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Michael
> Kelley <mikelley@microsoft.com>
> Cc: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org; Dexuan Cui
> <decui@microsoft.com>
> Subject: [PATCH] HID: hyperv: Use in-place iterator API in the channel ca=
llback
>=20
> Simplify the ring buffer handling with the in-place API.
>=20
> Also avoid the dynamic allocation and the memory leak in the channel
> callback function.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Hi Jiri, Benjamin, can this patch go through Sasha's hyperv tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>=20
> This is a purely Hyper-V specific change.

Hi Jiri, Benjamin,
Are you OK if this patch for the Hyper-V HID driver goes through the Hyper-=
V
tree maintained by Sasha Levin? It's a purely Hyper-V change, and I have
been using the patch for several months and there is no regression.

Thanks,
-- Dexuan
