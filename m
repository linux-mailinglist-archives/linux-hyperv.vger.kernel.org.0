Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47ABDA5E82
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfICAX5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:23:57 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:5728
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728029AbfICAX1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:23:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F90uD2JCnwho9vzGvId0tidYoEBXWmSo7Yz8rQyU2gqKv+s9l19Rhsg7yCtLQHytnUGSefSeF0RxEEr+cV8f22IXicu/UQfxZrN3I7npuBjGNnB0xB8NU//uAMQjDFx1gjyOJbB+Ij66y6v5U/lgBlgSptaCWZWVgFEs3rPHNqHEHprIFXUooKlvbPqA1yKQ2iRqrRvqKN8PLlpV1g/yIouvBp4rwbIz0gfHZRzDCTnszi7Lfx/sUb1wsr8bzJDNP4oCUpqq7pf00hnvGHpGQc0LNytVZiJlBAz1s6nPEeWCux4mtObf827Bh2j0QBhUHHyC48qogafCzbb4PpmoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtypEnsE04QKgPiMCZN3bk3hd68Lav0nZIRP5alzewY=;
 b=KaCO8O8pwIH7UNToHeGpfHAX4jECN/+EpcxpusyObIpSvVyPczRSvvkv0cIil5n6/cgFyEOFnbaXpy938zDJ2JGaJ3A93Z5QVoGNG2aPsDknhlZdpecoZS75eKlz7akRFYLkARRYSzHYln09Iz/fF9+6xpiqGBnyfsS/gFSETk7TPc4rcfdyrIY56NyxCLFdGBPS1WqdYVIA6RL4I/8UGuc6UmIotn41P0liXmkbPQfZr8vwouVFWs+l+eMc5xx+jR0p/1crwcwcMhK2yunQFR7dR7jR5Mq6+YEBMAThGWCDRYr4CcjKk/rh7EqVvH2PV+IEYguLkyDHN35jSnBhFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtypEnsE04QKgPiMCZN3bk3hd68Lav0nZIRP5alzewY=;
 b=eJpQAcU5rpEkSbFsywlhCiIaO4PrZfzbftb9aRuzAFnX/RquGrQetE0G330HIYtDxbmj8TdTZHlxZ0M6bUU6CpEZStkno3YNVV3dL64u1m742FUXAEngEvkq/2LqwdySGSW/jw49OXYfVxPFCw6UmF0/j8ZykrbCcm6EzjtN4qk=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Tue, 3 Sep 2019 00:23:21 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Tue, 3 Sep 2019
 00:23:21 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v4 06/12] Drivers: hv: vmbus: Add a helper function
 is_sub_channel()
Thread-Topic: [PATCH v4 06/12] Drivers: hv: vmbus: Add a helper function
 is_sub_channel()
Thread-Index: AQHVYe3K+ReKxTmpJUuBFwP7NoLouA==
Date:   Tue, 3 Sep 2019 00:23:21 +0000
Message-ID: <1567470139-119355-7-git-send-email-decui@microsoft.com>
References: <1567470139-119355-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567470139-119355-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:301:1::15) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 909f0cc6-5718-4895-24fc-08d73004ed0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:|SN6PR2101MB1054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1054F44FDAAD8C4DC570CB10BFB90@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(199004)(189003)(6512007)(66476007)(66556008)(478600001)(10290500003)(8936002)(3450700001)(52116002)(81166006)(81156014)(7736002)(305945005)(14454004)(25786009)(8676002)(50226002)(53936002)(446003)(76176011)(107886003)(2906002)(71200400001)(3846002)(1511001)(2616005)(476003)(71190400001)(6116002)(486006)(11346002)(2501003)(66066001)(86362001)(36756003)(22452003)(110136005)(64756008)(386003)(6506007)(316002)(186003)(54906003)(10090500001)(4720700003)(102836004)(6436002)(6486002)(43066004)(4326008)(5660300002)(99286004)(256004)(14444005)(66446008)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gt7C4oCqT/etKXKr1hiAYOmMdlIzhVeIzgCLcuq/D8DKSpQSdqLQVo62mZIm5fbNeAqdUPG9pPk/t8m10VDRxiJzKznL40u3W8Xz+LQWYnF1td6KjduGyYln4aysb+ybCT+elc7LzBTapbO0EnIeUhYIRMZu7oNJh9ir0UbfVd2SEmMwqHzOBYlajaAdlspr1o43xDDyyqK7tRGW5uU1LGwo/nK+CsalxPHlUY/+RXScMOSGnrwXxVlUSlipOPvYmiu9Blg2tEgSG87g89OTctmh071/BFRiNlrWEZ/ceGNrXlh6Xj80G0Q605jGKpG4SPYKIlH+F/tZLQ5Qvbf/lCbU0YAVlqin0fVKzDKzvV1G2o8MP1xO5p7fxqgC4Qyba7Uz9mRzOcetoGmd6quFobxC7Lyq5rVj2eP8mqjiVYw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909f0cc6-5718-4895-24fc-08d73004ed0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:23:21.3133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqPeOdEmXQeAO+x2bJt7h2g02mfYmzTrsuOl83WzSlnAqRTjrUZ7M8BjpAWgMVVzonJRsGyyhzWQtShyvOBiPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
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

