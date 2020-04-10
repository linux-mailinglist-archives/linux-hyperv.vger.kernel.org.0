Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0881E1A48E2
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2020 19:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgDJRXN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Apr 2020 13:23:13 -0400
Received: from mail-co1nam11on2138.outbound.protection.outlook.com ([40.107.220.138]:40417
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbgDJRXM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Apr 2020 13:23:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX7GCnRx11ZU4MuvqUWTBxdCGBOE7E6W1zWghRezX2swCTAKGaHBsQnh34O0fIAYDwPywbspNowRSkBnEvGpxvb3qxfQwGC9OeMitQT9FkS/T2rVerOSBf+ANNM6+Q5Xy1LRgKKkEkYn4GAm4RTIeIwMcGqbzrWI19qxbgpn+HGyFK3toGsopCvajZ6OoEOZOJyB5Zzfmti6FEBS95NdjK5JVQXJpv1Op6xpmxm9c+pFdoFGL/9zteuLoSsSL8uzAa19ZNN9kl3Ep2Rn2mf3xLFRm+VDWdrFQKc7Zwc09e3fdpOomv6eOkTRHhlKBciHbzbwuuqyF4cQDf+MaOSdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rv/gZo5cludzf6uwfAsAz+BuO0ZTGhfHqdBIFmDPH0=;
 b=PdZHVoVc4clnOFQegj9D8JXhUezoJKokRnG2SnwehMfJQGH1rf5z9jPPW15nL6KYPrFFeYJ02eyKgs/BekMQJupJGV0bGgvL6ffRE8S3culNkLkI40OLJnpQn2Jxas9AJUcD2uzzUviGYhdIJG//hUEFtyOP3BMG9vXBAhlMofouMOhwcSz8GteTcJYLTs6JTFH33vhtssOAt/Y2paeAEHiFCubCT/RzL6GY9KTEm5odqEqHVgCXlZnY4x7f+MQx5HtFYUQG8Y1ot9pSyxOqBj6nlCih93RH1trxnqW6rq18aKOFaupZPQPptrnSJazyCUceC6G/Cvn4nfkLdQJdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rv/gZo5cludzf6uwfAsAz+BuO0ZTGhfHqdBIFmDPH0=;
 b=FNV0Xi5KAipQLDmDS6Xw4ghmzDkmNcJKaUN7fu+ofh5MgyU+viGi+LH5stJupVci4K++yDZhVc/j4BZjDqXRkn6HwCErBuPRfxdIqaANOXnn/7Svi++tLfF7pYEshHBMfQWo8I+ar2tCub8nwA+Qaf83eA/IegaFOsFM9Lq7mvQ=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0905.namprd21.prod.outlook.com (2603:10b6:302:10::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.6; Fri, 10 Apr
 2020 17:23:10 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 17:23:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 02/11] Drivers: hv: vmbus: Don't bind the offer&rescind
 works to a specific CPU
Thread-Topic: [PATCH 02/11] Drivers: hv: vmbus: Don't bind the offer&rescind
 works to a specific CPU
Thread-Index: AQHWC6inmB58fyPCCEyte1k68AwF1ahyoOXQ
Date:   Fri, 10 Apr 2020 17:23:10 +0000
Message-ID: <MW2PR2101MB1052924E440C151A43065D0AD7DE0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200406001514.19876-3-parri.andrea@gmail.com>
In-Reply-To: <20200406001514.19876-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-10T17:23:04.4922826Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bf90aa89-def3-4350-9f8e-6bb810bb623d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9748f66-a198-4170-eaff-08d7dd73d7b6
x-ms-traffictypediagnostic: MW2PR2101MB0905:|MW2PR2101MB0905:|MW2PR2101MB0905:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB090580CD34A382CA1A5EE97FD7DE0@MW2PR2101MB0905.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(316002)(86362001)(7696005)(55016002)(10290500003)(6506007)(9686003)(4744005)(54906003)(2906002)(26005)(4326008)(110136005)(186003)(478600001)(66556008)(82960400001)(66446008)(5660300002)(64756008)(8990500004)(33656002)(71200400001)(8676002)(8936002)(81156014)(76116006)(82950400001)(66946007)(52536014)(66476007);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eMQzHfwt6Ko8ihpyvnIkpanslLOOU6O3SZhrx58mPqW/9LiEIudXw0Jp9nU8RnvHfrcLSlL0VdOBl9dQz7AAAXskC78W32tGE7+syBnifgMEfb6nX6+h1oOUhL6cDb0FxgxISiQkp9rknfuhohFnD6wt67kny/PlO5A13LlIExeskFKtxxHAUfHeqkqe30zk31ZudDUCoSlCdvCBPO6u7tzs5t0921/waQq2OHpVX1fwFJzPO2VvSOGlEruSu3jTGu/EYLcz71W7iQz2tlcP5q0Q+SD6S59iuhDsYVz7Fm88uxVXoKfdz7/9j0JgGCC1eRCD9lmLLP9r6W9p454R721N5KqRNGSTSkYLxhPbVqiJJEpRFmysSJNBB2XsO9Y4kJDHKdXc49p+r3Gl0IYWYLQ9JyqmVkPcyy5AeZfJneSKk2qmhrOEHVhxRQ/CfJGi
x-ms-exchange-antispam-messagedata: 3ubuCEOOeSOAE58zJtXsr5TtSH7+j7Qx4l3/uRBcg5iZf22EYj/bgzYXVx1N6KRirwkbHr5PyWikm7DR+6aJY/ucLk7G7FBQIzG9uYzJKSNHS69KtpRMYA0tMcusHtYa7E4mdvTQNWn7g5LZXpvNOw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9748f66-a198-4170-eaff-08d7dd73d7b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 17:23:10.4862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROxHXYRYnrJf8SbrNpJN/+EEccwvVktX9wMKDNnwIvQOPILJJCKRKED+e7zCZoiMc25k7K8FTACwCJSp2oIALQxi/FYiv4t/QifqcDIyIvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0905
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Sunday, April=
 5, 2020 5:15 PM
>=20
> The offer and rescind works are currently scheduled on the so called
> "connect CPU".  However, this is not really needed: we can synchronize
> the works by relying on the usage of the offer_in_progress counter and
> of the channel_mutex mutex.  This synchronization is already in place.
> So, remove this unnecessary "bind to the connect CPU" constraint and
> update the inline comments accordingly.
>=20
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 21 ++++++++++++++++-----
>  drivers/hv/vmbus_drv.c    | 39 ++++++++++++++++++++++++++++-----------
>  2 files changed, 44 insertions(+), 16 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
