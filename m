Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E17612A037
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Dec 2019 11:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfLXK4V (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Dec 2019 05:56:21 -0500
Received: from mail-bgr052101132087.outbound.protection.outlook.com ([52.101.132.87]:37873
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbfLXK4V (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Dec 2019 05:56:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kuef6q344Z5AoD0k0hQKleqN4XnVa5dQB9d9OZTvelSWd34DMaJm/6InteG2tz8m4OWbOYxuHrmX+0zt8c1T/ykDytr+lb5Z0cBz9g0kRuqTYDxYhQwUNCBPwS9KIQykvQ/LBiCFEOqSuI0adcW1NYdU2aIMrr5CDIDLZpEyXyg5s18lzTxPx6acN2jknM/VvCsB/T/FXZBQczHGma2zpfVdEcHk2nzdoqkmytWhMoCd3BtPMfyRqF/aZdZCyXj84FQK/SKfgMoIcQ15KA8yAX9pVdfDVQ+4EzCoyN3NIGv6XBGWmsAlJtJmr/W1ehxYXStcMxfvHFUyKE+Rd0bWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTXrUHeyogWp9WR+fs0vDJWT+Sr9iqREGV+tYF2uq1o=;
 b=nKxutBg2B64JaN+I3bWqaLBwQ5sL3lbN7cD376Mhw5P0K2iTQCVINzFmHlHtWl3C68+vIOuSzg9qPkLhqZIStzQdFQ+hKdKlD3sav/xVJ9XpK2kXvE0IgJiS68i6GwniSfYCqRDLu19emZKNr6IPsM4eYOEAw9B3nTeeDIur2L9/1HydzfVp4oZcHi3HnGq6j1dFII5QbHlzsTK/i9hNs7o+kB0Xm3wxzW3RYfIqNabhdHjTCWDPL1aBWHUN9h9LSAwfxnY10wtn9nQMUkc1M30j3CqmXOB3Ze/hf7Z6o1YJ8rzODSZh7OxaVmxfVZY2E3VOV6D1zoRRrYikmcLPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTXrUHeyogWp9WR+fs0vDJWT+Sr9iqREGV+tYF2uq1o=;
 b=jkh1srNJpRXQ6JlItFATKvsWQWXCdAxBiFwwzy0Km39GS+OhP95YNxN+N0A3Dgq7+G/xSK272+hXrEWrYhOCUgsdVdr0ZqUgfHtk3t8NI3Le6838rxNvC6U7lhKj1hcnZ2zPr/0ruSjAdWb0VjCXp/hbvIhE+8UlNFHMpYjgWiE=
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com (20.178.80.22) by
 VI1PR08MB3951.eurprd08.prod.outlook.com (20.178.126.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Tue, 24 Dec 2019 10:56:09 +0000
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12]) by VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 10:56:08 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: flow control in vmbus ring buffers
Thread-Topic: flow control in vmbus ring buffers
Thread-Index: AQHVuki/5e8dawcR8kGygRTboGxxog==
Date:   Tue, 24 Dec 2019 10:56:08 +0000
Message-ID: <20191224105605.GA164618@rkaganb.sw.ru>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,
        linux-hyperv@vger.kernel.org
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0402CA0038.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::27) To VI1PR08MB4608.eurprd08.prod.outlook.com
 (2603:10a6:803:c0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3bc0069-4d0f-4a50-282a-08d7885fe1b4
x-ms-traffictypediagnostic: VI1PR08MB3951:|VI1PR08MB3951:|VI1PR08MB3951:
x-microsoft-antispam-prvs: <VI1PR08MB39511398F4109B9D8ACFE851C9290@VI1PR08MB3951.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39840400004)(136003)(189003)(199004)(8936002)(478600001)(6512007)(1076003)(6916009)(5660300002)(6486002)(86362001)(66946007)(66556008)(64756008)(66476007)(186003)(66446008)(9686003)(6506007)(4744005)(71200400001)(2906002)(36756003)(8676002)(52116002)(81156014)(316002)(81166006)(33656002)(26005)(30126003);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB3951;H:VI1PR08MB4608.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;CAT:OSPM;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v/5mdBmiI7/xE5/juN21haxN48zeBsDOdRznp6vBY5EeehyJ78UqSqJtpx20zr3buO0NVtvR8XnyKldZ2ft7KqunGYJ9P7xwMp7r+rqCOR3PJjs45oyZywko98CE/QG0pOejh21JYG8oj/L0BDjgJS8uW+cGuUJD2dZeCPOVRqSTngzkMKmfrMZVuJhfO4U+fjStyeu0lvQK4O7MkeJpTi69BTZQdOuhKvjmNb0f4TEDs2vEPhJTyeilBW8B5oI1ZeBrSKkMeM75zlbo3TAAnSVqm4HrUgtt7JDB3NDXRdF2zROqnn++WyQGWyyZIhgwXfuIqO12oMSsLCjmwHTMafm4TdME0AffzBKFiAZ6Vc1arf9pL4NbZcEIjopLUXAO1S0kE1sb7M1cf4CpviyFo9W3EwiKYEmzCZirkcXdb1W7AULnCiQF7uCoschggv+HLdPsokriFJJg+PONqCTrM87cfaVxUWIva66K8zNN06BLZnVG+nH6ycGd9hdahVsA4OmarPMnhDqIq12pTqpPuaezrawaGcyB+M1Jx36LGxTtN3fPHqoCi9Ku+fuOwOzH4dGlAUmC/hqaUmWdJeX//cj4KdopSCkKm7R3wDryCIzezd3eXjqlpSTdCrwyED4DxNBOK+TsHfV42+/QUzGoEHQm0ZeHNfFVHh2Gk6QmbzR9BW5FpnC5o4ibKGoS0fM6Ii9DB/JK5nqlxOmJkASqt+u4NKS/RBGK09FOGyzh0MXgwnFbY2/Y+cv7NPhmagGDMwLYeEYYjNsDaCuQ2X31nw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E279C5BF7D539B4C86478BAB284FCCF3@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bc0069-4d0f-4a50-282a-08d7885fe1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 10:56:08.8474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kN8zorMszpHrLOo6d3pS2+azkfQl/9XdNuUfKeP37+meO2p/GoeY+3yQYwy1NTDpVS8QKXDAtenVhOMpLZFDbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3951
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

I'm trying to get my head around how the flow control in vmbus ring
buffers works.

In particular, I'm failing to see how the following can be prevented:


     producer                     |       consumer
==================================================================
read read_index                   |
(enough room for packet)          |
write pending_send_sz = 0         |
write packet                      |
update write_index                |
                                  | read write_index
read read_index                   | read packet
(not enough room for packet)      | update read_index (= write_index)
                                  | read pending_send_sz = 0
write pending_send_sz = X         | skip notification
go to sleep                       | go to sleep
                                stall

Could anybody please shed some light on how it's supposed to work?

Thanks,
Roman.
