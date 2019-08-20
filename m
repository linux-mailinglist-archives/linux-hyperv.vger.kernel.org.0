Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA461953D8
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 03:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfHTBwI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 21:52:08 -0400
Received: from mail-eopbgr820091.outbound.protection.outlook.com ([40.107.82.91]:42832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729007AbfHTBwH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 21:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORwChN549d0j1mITQgfLn605/CAPPTFMBmMV1GiPBk434yGmM2lRqCEnQGj9qlt/KJ6HGlmt5dtXfpbz263jQ/B6VB6hObdJK0iY0q8IDH9uWDDLHbnzSDMp3j8cBjf3QW0C7L5m4Vw3vEPmbXNCLWKB3S5XLaNSayh2j+eKBfjwdt7nArN7FRnWeaBIAcvAGSl/fbV0+l3JNAvHbqoEzpC+AJ4U7vFjOeueXzoJ9A5SUw88FyT4bk4Sf0UOOqEcQoK7gnJKlTIhejw3P3oIFenyGhVzuJ9j9x7d7Ws2h0jNOsPQam/hNng4aqyFgoRxTdhYu4p+sbedME2f2KGKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQjr+DhFDbpXh0g+wJMeltpS0cbuN6QfFesS2IJwoMQ=;
 b=ZWsC4A3HlhciEAxE4MI8mbAHx8jA979+H2N3msGMkd+aG/iZ/6Ronn17luRyZBeSTCrSI2BD45l4K4SNZWWPjAMNOvwtoG4Pr9+c4A8v4aobtVIbGH1eDRmfu9CpD1hsznUI7EF8dQC0YfNjki8OVLVC7gaFre1UA/M0PcgbWKHDF1wzJV9ZYcWRFFsAqE0VLayw1+B7g9YjjFI8x0JLuXxSeL0TaUwW0n63AuHFJfBcfWfBttd+es+gDGiyQ19nSVwKMJaZKgVPOO7n5bDEqlzzAfBWKEop1igT8KIRl2U4C9evss8xNbVKN1VZKbX6ovzR4G9x/bERfuP61j5mAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQjr+DhFDbpXh0g+wJMeltpS0cbuN6QfFesS2IJwoMQ=;
 b=AToxHLUZJiE/7lNfGcIIBjRiZuIL2EL++zvaP8gXiJqtX1k4Fxhi9bj8T579hT8HTN1+hdr5GVFX7F3Do27oQou1mEUSnlnyerf4oZFwTwMm/NBx1jEDkrz0xZ6YLfEFqlQKvr/WphDRSlkPxEigvbPCzJNrUIlv0gZVg4MpCx0=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1133.namprd21.prod.outlook.com (52.132.114.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 01:52:03 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 01:52:03 +0000
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
Subject: [PATCH v3 06/12] Drivers: hv: vmbus: Add a helper function
 is_sub_channel()
Thread-Topic: [PATCH v3 06/12] Drivers: hv: vmbus: Add a helper function
 is_sub_channel()
Thread-Index: AQHVVvncakvN3Q3Ji0SHQLvfbh196w==
Date:   Tue, 20 Aug 2019 01:52:03 +0000
Message-ID: <1566265863-21252-7-git-send-email-decui@microsoft.com>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1566265863-21252-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0056.namprd21.prod.outlook.com
 (2603:10b6:300:db::18) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66ff192a-d63b-4faf-ab1a-08d72510ff4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1133;
x-ms-traffictypediagnostic: SN6PR2101MB1133:|SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1133C0F6D93EC30B975DD051BFAB0@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(64756008)(6436002)(3450700001)(1511001)(50226002)(14444005)(81166006)(256004)(6486002)(2501003)(36756003)(66556008)(66476007)(76176011)(4720700003)(8676002)(8936002)(66066001)(25786009)(66946007)(22452003)(26005)(10290500003)(53936002)(99286004)(478600001)(43066004)(386003)(2906002)(6506007)(3846002)(6116002)(102836004)(186003)(54906003)(476003)(486006)(10090500001)(81156014)(5660300002)(316002)(110136005)(2616005)(446003)(107886003)(11346002)(6512007)(7736002)(14454004)(52116002)(305945005)(86362001)(4326008)(66446008)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1133;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZFAt4zXmB93Wpt9+RQ1OypfskZS0oUIZ08lxOWGtDX6ck1AuTJW1WVdGQQJlCzzJtvkKV/gGK8UYk7lkha/hRwMDAvoQM8I0itOjbtTUZLsGA0/arUX3wqqcxFdT4bfJdIOdmw2L9jwKV7hZYq+Zh7x8FQ5VeKz5fSbuEdGIcNqM3AXtprZH/Q0m5b4dPfRxssgw8M87S/31JLSoON73zAlRfwYlnmlMZ3bqIMJ8gChdGQ7y+gQcaMhGb5A14EkSV9K426EoRjtveag0JbZ3BEUsjp2c7p4bYUjAyDDCoNdUveq2up6U2vpPZxk2LQRCNyNzmPaOw7GJCDrObuZ7LNz1138OoGeMQaQrmWyvsoNxg7QgMO0EHT7Pj7jgg1dPGaqHHZ7d+Y7EH/cB6FnFwZyGskXM82KFBgJQAQOQYNg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ff192a-d63b-4faf-ab1a-08d72510ff4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:52:03.1500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nIcpLg8QGsLlCiCxiaWmk9nR8VKmvcAdIotYGaiuKElvWKqxOfVbauYeti7FNwaUDXs2UXOaZ4QmGcLs0fvf0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The existing method of telling if a channel is sub-channel in
vmbus_process_offer() is cumbersome. This new simple helper function
is preferred in future.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
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

