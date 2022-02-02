Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3B44A69B8
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Feb 2022 02:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbiBBB4F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Feb 2022 20:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiBBBz6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Feb 2022 20:55:58 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20702.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::702])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0564C061714;
        Tue,  1 Feb 2022 17:55:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIbnQV9aD0JamcA59H1W4o2RbTlOzSLrWmwpUOGKpfrAe7lia6OCXtq/kJqOwsaPSBULJmQk4lWGGTsaSt/H5fj1hkaQ5URkp3UDtHA4B/3FYbbNyAXwH+feWvlQQP89t0uPYs8Dv32Ycitib+aEZ58gqwX+MJGsLcXesUzZZOXNef/c+Ch0Q/fUa5gPhTC//lIrM7LeVT+K9UkeH+rSOX/eKcDfawG5zjRbpAZ4Cdbgm7s7ffplufrxVJecsLytcAsxnNDQL3djhL2gxVeVbi3ZqTLo906mqvEEHzR4rxHbK01Nizw1w8DVIQpT6H+qLbPoQAZsI0YxQF79BDklsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHPi+wCyc/K996h+m7xhh+lnw9GpLBf455DpfhaCeko=;
 b=gRNSCsEhk/scSDYOPeb+qjGA/iCGo2DjkkzZZFi3HIm/jwezGYAie1IwuUMHWG6Fmze+NNrlpUoEnZzDhToWBCGD5DwM8JSNc3yiUt+Ex4U5PCI0vvhqLalaXRskb5tJtNVZ+SXfvJLg65F+58K+LmszyfO42cVjaJcEHhGa63JDQX3+RGi8IOxUP0Ugp0T9iunIKpfwsbRcAHiJFxs6Cm1AqwQq5aD4bKN6j1i4PBw+D5axW0ooql59DM6uSZe7AXY+VG9oEYeNe5nAVWKJgyeQRjYt//XIS6sw9IYj/hmVMBieSLqij38dpqHAt3+G9t1F1/GP/JwfzWJntDEtMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHPi+wCyc/K996h+m7xhh+lnw9GpLBf455DpfhaCeko=;
 b=RYOrsQgRkB2UdmYTCR4WERqbAOkqir2Q2AQTxZBq95nkLoBt0Iw5sIk8w20kLQsDRoHoku1qn/6Qpu4tAqpt8Yam2TR9ke2xJoYbHVte2ei89tIDMZRwkP4b7MFGPejZvMzu60ioAnRkhMun48o8Ul92JV0cmY91fi8ulEpT06g=
Received: from TYZP153MB0430.APCP153.PROD.OUTLOOK.COM (2603:1096:400:2f::13)
 by PSAP153MB0486.APCP153.PROD.OUTLOOK.COM (2603:1096:301:69::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.1; Wed, 2 Feb
 2022 01:55:45 +0000
Received: from TYZP153MB0430.APCP153.PROD.OUTLOOK.COM
 ([fe80::5909:8f53:4686:f271]) by TYZP153MB0430.APCP153.PROD.OUTLOOK.COM
 ([fe80::5909:8f53:4686:f271%7]) with mapi id 15.20.4975.004; Wed, 2 Feb 2022
 01:55:45 +0000
From:   Purna Pavan Chandra Aekkaladevi <paekkaladevi@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] [Patch v4] PCI: hv: Fix NUMA node assignment when
 kernel boots with custom NUMA topology
Thread-Topic: [EXTERNAL] [Patch v4] PCI: hv: Fix NUMA node assignment when
 kernel boots with custom NUMA topology
Thread-Index: AQHYEx9Vg3YdRJXNxEinwsXNtwwx7Kx/iUmA
Date:   Wed, 2 Feb 2022 01:55:44 +0000
Message-ID: <TYZP153MB0430CC8F4C0BB7E410316505C7279@TYZP153MB0430.APCP153.PROD.OUTLOOK.COM>
References: <1643247814-15184-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1643247814-15184-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=48d17dc3-8ebb-44a7-9cd5-52b00f53778f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-02T01:54:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86f1326f-5c23-482e-2680-08d9e5ef2049
x-ms-traffictypediagnostic: PSAP153MB0486:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PSAP153MB0486C02321B6232F32112D17C7279@PSAP153MB0486.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:546;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5qYlWSHGNwTSun96eRt9Kg3DTpaep1BiY3aGTWeeC68P1zeJnkIjuKcBrq8VBCBMsZ6pENCE7eyd5bSNiz1ECqb7FEViqlwhuqCD9n6voJScZkOKPuCj4tbFqDGJl1RWAN1f6qvYsRPIgVja9/Pf+UkUr6+M4JDoknsHVavNlZR+JW1jqrKkSyfoW2KCVWWCZFldkkHz+dBJ0cFDOKe0vyf0liCXqpuhao2MpxF3nPEeAUnoLLcH/3mgNNa8uRYVZ6UYDhWsbBl+jVeLe1P+t6CNgYOQPdqlUXromaUUMpxczD6XbneR++p1reQXFl3kD4IOiuWGtOzAJGForM7XjFM7WH8rnuhZA+vz3UB/hh0B1Z4aQ/AAt46/aMtRaBzzfkB0I2Ged4O/QlV9S3zlkJj6r97PwmUEKtBPp6/fJwYA/HAlkvmx2HJ5OMT896T5rHnBEyUtp9M6GtdN4uS9hNC/hSSFu+Po1DRBkBNgfIIGEhjvJo3i4SOoIFyyip1CJktIATJEZAwGy3yVuSTzKCK3HtA+HRPfw28Rbyv/jW4FCsLdT9l5cqvUx0Tyc6qFNuTRaj4huFeiMaiYZURMmPjNbR8fha2FMwysLT0N7cWh2/8sx+KJ52Q64cOyr8WOU3rOtjh4iT5zdNLwwsWpKBYk1MGYizDCp8muLLenbiMRxNtD5TarySPsOeES6LPzN1Ey1QOMh/lQmtefYJdznQU4yePXN9pAp0hYP6dhyHWx4R4ccsl0tc2ufZ5GdtACn/r3vHQlXIa0i+Q8pUm7XTwqcsVR6etoS3nK7nK1wg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZP153MB0430.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(66446008)(4326008)(64756008)(83380400001)(966005)(86362001)(8936002)(66476007)(82950400001)(8990500004)(82960400001)(122000001)(76116006)(110136005)(38100700002)(8676002)(38070700005)(107886003)(10290500003)(508600001)(55236004)(316002)(55016003)(9686003)(7696005)(6506007)(71200400001)(52536014)(26005)(5660300002)(53546011)(186003)(33656002)(2906002)(10090945008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/GqUMCk4hsZeefnCbFBuxtkOQ0UYk9QE/msyKin4Qq1W9Z2GL3XJTHc/+W9E?=
 =?us-ascii?Q?91rxJPt7HthJcbKwmc2reUFoO1SdP5/B9mr10eF0sTyUImOBicPYTwBrVOxT?=
 =?us-ascii?Q?nMHuJy51qLefFRiCM8faMwd4UOkO0Pg3Cp9bmVzdhsA7lM7xwtMUAbJGzs/5?=
 =?us-ascii?Q?nf6z4v51kLKAAYL7/W9/bUhey6vhZ/i8Gu8xh+L3MIyw0ucKL4l+UmsZOSBb?=
 =?us-ascii?Q?70r9SfOO+sanjcbGozHdl2VkDSWhibWZIo+Td5ktKTuaMp7+93WIQ7nZYT9s?=
 =?us-ascii?Q?G9/+hj7698MA3VDFaZ7jZTXPZVkcQDMqJzeaED7g49Ndj4D3MNxs5bB809AY?=
 =?us-ascii?Q?xqdFyXhIfOP8bU3NoMInTeMcN6dweCTY8Gxn2/rCfIVeswIt7gYtq0iPHZAp?=
 =?us-ascii?Q?+8AHXsZZNymEVxPQgy0I1QFy7GjN8Y8RBQPZutQwFWSYzWP2aX8AoSs7w5as?=
 =?us-ascii?Q?SDylWqvUs6fj3PpIc2do8shBYC22NgyMIFwblkn3Wc2GYH7gk1+4rqYiLgkh?=
 =?us-ascii?Q?uePZppOSqsMyQBp+S/oKeg+khI+700Jyk5jdCOucbrw3dei9mWV7jReneq5/?=
 =?us-ascii?Q?TOrew0kvzi1gcJ1nL8tiflD5OL+fi4lXf1oA7ax0hI+b2bRDt6PzzDvitGey?=
 =?us-ascii?Q?yV1U3iFgKTEwnGIblkOninDMSVt0QerYUlspPxtXX/Gj6J/H4bd0NqO1Tovt?=
 =?us-ascii?Q?LJi/mjy6iPSDYem8SsUEFWuDXCay+LRtIc6nKvdBlierCWqHmI3pPL8QSuDi?=
 =?us-ascii?Q?0p7H245zJEcUenioER9mdNUDMTfAzqiFfDROhADjyPR0YOpwuGlPNumvwyIi?=
 =?us-ascii?Q?1iKojE8shtsgI7sVkVdFEsRYLwLwGTFs8C4MqUVb5hfJeML9puBqAoyFNCtU?=
 =?us-ascii?Q?Vlo6ITh6pn3qLpnB3bQzNif/PfQSq6jbfEJYdntD5h++IUc1gXg8hhfqnpaF?=
 =?us-ascii?Q?0yQSC56Y27ASUEr2/NwQMMTkv/RilC7E5GhESuuYmt0wlDpRA5SHRI2MfDX3?=
 =?us-ascii?Q?MU5kBuz7iNqS5As3VCsYB+CtdJfdhVFmY55xS4IFRF1Dm37WZlUVp3uMXLBr?=
 =?us-ascii?Q?24AbvtkAjOSGGNR3ntnFsJP1d2mBPKesIsWelzycKlrJWDxGwKnXwgj6kdy+?=
 =?us-ascii?Q?gpX1LRYXjhNzILUrLSJCY4gixj7qGwUz0k1k7uRxhChppIZBvTJC59BPVz2i?=
 =?us-ascii?Q?yYKVGLsEV61gC+t+sYfdj4v5+FmYBnL0LLRt3zYa1g9uFLBAHV20AypGAfci?=
 =?us-ascii?Q?2BPRDWQvJzqk5xQkvGnJ/75KCG2M9AxxSZ+ziTQ9KR99M8wVll8NsRuSttcH?=
 =?us-ascii?Q?XgMX8BS3IvMJd6576rvXLAXfer/irJTLxFWbxYfA6JKlH+rfFKG3/uecCWkN?=
 =?us-ascii?Q?V5wF2d4HGi+LCBGxSYCND7DO1ST5EoKo4Zk6gRAyPZcvubpugbDhyXq0dBF1?=
 =?us-ascii?Q?Cvna2fGImaIHiFcHUwTqoVBLshKIMc4xNuaY1qbgxO5gg0FOWIoAKyQuaE74?=
 =?us-ascii?Q?9IB5Qky9mpvRdejf8SdJ5Bo5gWR4FoJf2x4n+MQ5IJ1Sxdec8OK5MqmHtYBv?=
 =?us-ascii?Q?sNJKjLaZYXAJigtoC551H5S0BZLoMggy7JkF2H/indgU2Eab/NxTBD8wHaE7?=
 =?us-ascii?Q?+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZP153MB0430.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f1326f-5c23-482e-2680-08d9e5ef2049
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 01:55:44.8595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1krYr1CtffaPaPlPThflbLYQ0t96ImuzXx8mA5nClLU3bToR3uX7njV1w1mZy+tKEUJJqXxnfuWHq3LKgInZF8lsRZyssvOT+8840VwQ/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAP153MB0486
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


-----Original Message-----
From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>=20
Sent: Thursday, January 27, 2022 7:14 AM
To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hyperv@v=
ger.kernel.org; Purna Pavan Chandra Aekkaladevi <paekkaladevi@microsoft.com=
>
Cc: Long Li <longli@microsoft.com>
Subject: [EXTERNAL] [Patch v4] PCI: hv: Fix NUMA node assignment when kerne=
l boots with custom NUMA topology

[You don't often get email from longli@linuxonhyperv.com. Learn why this is=
 important at http://aka.ms/LearnAboutSenderIdentification.]

From: Long Li <longli@microsoft.com>

When kernel boots with a NUMA topology with some NUMA nodes offline, the PC=
I driver should only set an online NUMA node on the device. This can happen=
 during KDUMP where some NUMA nodes are not made online by the KDUMP kernel=
.

This patch also fixes the case where kernel is booting with "numa=3Doff".

Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and support PCI=
_BUS_RELATIONS2")
Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@microsoft.com>
---
Change log:
v2: use numa_map_to_online_node() to assign a node to device (suggested by =
Michael Kelly <mikelley@microsoft.com>)
v3: add "Fixes" and check for num_possible_nodes()
v4: fix commit message format

 drivers/pci/controller/pci-hyperv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 20ea2ee330b8..ae0bc2fee4ca 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2155,8 +2155,17 @@ static void hv_pci_assign_numa_node(struct hv_pcibus=
_device *hbus)
                if (!hv_dev)
                        continue;

-               if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
-                       set_dev_node(&dev->dev, hv_dev->desc.virtual_numa_n=
ode);
+               if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY &=
&
+                   hv_dev->desc.virtual_numa_node < num_possible_nodes())
+                       /*
+                        * The kernel may boot with some NUMA nodes offline
+                        * (e.g. in a KDUMP kernel) or with NUMA disabled v=
ia
+                        * "numa=3Doff". In those cases, adjust the host pr=
ovided
+                        * NUMA node to a valid NUMA node used by the kerne=
l.
+                        */
+                       set_dev_node(&dev->dev,
+                                    numa_map_to_online_node(
+                                           =20
+ hv_dev->desc.virtual_numa_node));

                put_pcichild(hv_dev);
        }
--
2.25.1

