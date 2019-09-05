Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33C3AAEE8
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 01:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391354AbfIEXBt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 19:01:49 -0400
Received: from mail-eopbgr700134.outbound.protection.outlook.com ([40.107.70.134]:14272
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388923AbfIEXBW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 19:01:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IH/xO3nPEwM8Cjz650dRv1c4iB4byOys2gpDU9iReA8SmjTE2HkxTx7jHeUvPrO9pTKYmQKsEI9gLS4IcZl5bjiUIcLIGBaC6J0daEw5Uwxrwh+6gUc9AdCD3Mf792SeJBhDSWKQyStYkhSCS8zof2Ixm6q8loU5DaFL2BBMZEkfAjmV6QABG+TcmXQwRrSKNfl/JSIxcvQjpWDYatARTZNqBeKRSvh4+U8b9Pjd4CHaqfKm9rmDHONiP2izW6u8yF8L7xtkCnrnaPQJH/LSzP0eV8aJYRFYb/vmineQvh6qJMY95nSCk0DVXGHYh9K1NOmY3lEPuw7WidN+oHmNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtypEnsE04QKgPiMCZN3bk3hd68Lav0nZIRP5alzewY=;
 b=gHmoWJ7ztfqGFraxBuD5nhHnfyv8GYOYJfxGZeMp99TQ3Oi5ZWRWag5J1D6agDIhvpooXrBfKeQvhbdfDcZKfMryjFFX/6D7NHx2L9Y+RrBMUqr3i+28pUEX77gXdZpiHsxd7kymRVirWUSxDpneenY7PXhddKE3zrIYLuBFaFV1dUoTo6pQTcK33LaUg+swK174c/JZixiAx4/E4ILba9t5AH4ocijayES7PDEp0GMxX+5HytfFquhXEyR41EpUMrbc80RG8xVZ/iIw9Tb6uL5IDBSzmhyM05FCYTPjsh7CCs/htupUY/ttfT+tK3Be3bP+YgycYk2oD295Y/aLog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtypEnsE04QKgPiMCZN3bk3hd68Lav0nZIRP5alzewY=;
 b=Ai4cXKG9BreZvslBlQx92vhroADy9RbnTdB80SItkCl1SNa+vMo5AZ7KsQi68xX22EFjz5uGCiZAUtId4+iAqq6f66CfzSy0QT4E/0NloPbgwfTPjWt/9YgGHr6VQfjorccd+IPX7PNm6d5oPZHIAAz+xTMkzo44PrcO3idS50M=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1038.namprd21.prod.outlook.com (52.132.115.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.4; Thu, 5 Sep 2019 23:01:17 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 23:01:17 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v5 3/9] Drivers: hv: vmbus: Add a helper function
 is_sub_channel()
Thread-Topic: [PATCH v5 3/9] Drivers: hv: vmbus: Add a helper function
 is_sub_channel()
Thread-Index: AQHVZD3S8dWi9FbX2UuDpeJl7Q2hEA==
Date:   Thu, 5 Sep 2019 23:01:16 +0000
Message-ID: <1567724446-30990-4-git-send-email-decui@microsoft.com>
References: <1567724446-30990-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567724446-30990-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0048.namprd02.prod.outlook.com
 (2603:10b6:301:73::25) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e25c0d11-5f11-4d23-1932-08d73254f523
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1038;
x-ms-traffictypediagnostic: SN6PR2101MB1038:|SN6PR2101MB1038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB10381DBEEADE3D3AC6E918A8BFBB0@SN6PR2101MB1038.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(6506007)(66446008)(256004)(14444005)(10290500003)(478600001)(476003)(102836004)(186003)(36756003)(52116002)(64756008)(71200400001)(26005)(11346002)(3450700001)(6512007)(71190400001)(305945005)(107886003)(4326008)(446003)(66946007)(316002)(76176011)(7736002)(6436002)(66556008)(386003)(22452003)(66476007)(6486002)(486006)(53936002)(2616005)(25786009)(14454004)(54906003)(110136005)(5660300002)(2501003)(3846002)(2906002)(6116002)(81156014)(8676002)(81166006)(86362001)(50226002)(4720700003)(66066001)(10090500001)(1511001)(99286004)(8936002)(43066004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1038;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JybGXLF1/ZGKz2vxF4ZzLcOobLJ/F5gorOMeIrHwknQrCpps3ptc84X6x299wdbd0uTSdwQQnJH/O3we2XHK3y8++IQvJ01miuWF3N6xznPrxpRhiqdWxm4OeukuY0SNrehKa7uklUAEWcQklSkCCc6zo+b53EqSFNqysp4d+zgcJE/qf+EIEd2bgCX+kNRdy1dCLNevz9SrvW9iqe230aitMqqbdMw00FOtWWgsVAmBiogQed7Sx1U3FGYecNeM4YwktsihNjphknguhILHyGiubUGTzgTggMzPhI28yPCQezUOzszzW66T+VEUCheVCl28djoKkdwkYZJwIMFkBQYMAAY59bm/pf5wuvzUtgzNp2LOz8tkRq/VUwklJftJKYVEmZ+vl7jKUm9T6qTNQgFA2SaC5lOBAheOVTyLkJg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25c0d11-5f11-4d23-1932-08d73254f523
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 23:01:16.9303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBXTqazh7NgnxqVkCgqMDoVaWOhj8MQzBbhESkVLgy8w1lm1sjWOWpmZ9htmREZSLDqyrYg4VelI1H7VB1nRcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1038
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The existing method of telling if a channel is sub-channel in
vmbus_process_offer() is cumbersome. This new simple helper function
is preferred in future.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 include/linux/hyperv.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 6256cc3..2d39248 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -245,7 +245,10 @@ struct vmbus_channel_offer {
 		} pipe;
 	} u;
 	/*
-	 * The sub_channel_index is defined in win8.
+	 * The sub_channel_index is defined in Win8: a value of zero means a
+	 * primary channel and a value of non-zero means a sub-channel.
+	 *
+	 * Before Win8, the field is reserved, meaning it's always zero.
 	 */
 	u16 sub_channel_index;
 	u16 reserved3;
@@ -934,6 +937,11 @@ static inline bool is_hvsock_channel(const struct vmbu=
s_channel *c)
 		  VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER);
 }
=20
+static inline bool is_sub_channel(const struct vmbus_channel *c)
+{
+	return c->offermsg.offer.sub_channel_index !=3D 0;
+}
+
 static inline void set_channel_affinity_state(struct vmbus_channel *c,
 					      enum hv_numa_policy policy)
 {
--=20
1.8.3.1

