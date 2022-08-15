Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC874593D07
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Aug 2022 22:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbiHOUNW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 Aug 2022 16:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244673AbiHOUJn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Aug 2022 16:09:43 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021024.outbound.protection.outlook.com [52.101.57.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C63B84EC0;
        Mon, 15 Aug 2022 11:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6+AVY9GpsCv7Ke9pNLLLJt4buMHBs+thXD5d2SMAMpGqxA/622CXZrMSM6CVW7F7ImTUzYr53QiIwYn3t1EFPbpZjt5H0FRLyzn1v2GGstn6gIxvgjQgFk0x8D/lFXyH21FWrQA95SBoqw8y5kFGpZydYVFYIF9CP/o41FgvEIQD/ap/IkUDT3SP+H+clhz53WxBOrbq4es/36p60ySmeb20tfHbhB4cI1T7U6+hSQLDDXkfLCMcHc6L0sQM1F0KDTPpV46cSDZEXplqyR98i296kIqE0nen9IatR1AGAicDquUMdnoPAFPxAp4Bm8nFCP0Tc/UEczih6J1QsiyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5083/8B01yFp2faTJGAh4yAMLUgiLV2WVO+eUItyvNE=;
 b=Rw1Et9Wn3Y/AgM01r5nIvSIoKxle5jutSpF0i3haxGI+nWCmcfYl56Xh1f+DQ7NpJjy2N4CQeVYwoIJBgj4PboKEW8QhDN/ELjvq03OJptZAtTuUg/uxOlRgQthtMKxkw5tbyCnnEuAFh9AiwnCg5xOqCt2Nm6GWBU4M0D2JehH0yIBT0cdY6PP7URn5uzVUsdukLMeFVPBkuF3et8hcyej1sKTeW8Q1nDhg3aHmEUetTUAdiOuSGtIvyH3kHA85Ewd7fI2Fy7HQEh6Sf3QnF/ZNAD4GVT/H9brQLbromQemmoIJQvWgnM73p/srrnZFjCa/hGPhYhmGpE+5hu89iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5083/8B01yFp2faTJGAh4yAMLUgiLV2WVO+eUItyvNE=;
 b=a9eXMzZtLs1BliGx/YeqzZftVXhmZym2FOaekDAk7cNT5aoxYqzLYyomHfhZX0UnT1lFoI43vgwT5U0rqvrQdstl/1Gq3YvwktHdOfkOBT9E6WoYl1nD6sIPTJ3rO0xlWhpLFVSt3angkOzo5wklC1mTz7wS0yD4q71S3Gann4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BY5PR21MB1393.namprd21.prod.outlook.com
 (2603:10b6:a03:236::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.15; Mon, 15 Aug
 2022 18:55:56 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::543e:7a5b:a5a5:f988]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::543e:7a5b:a5a5:f988%6]) with mapi id 15.20.5546.014; Mon, 15 Aug 2022
 18:55:56 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     quic_jhugo@quicinc.com, wei.liu@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        robh@kernel.org, kw@linux.com, helgaas@kernel.org,
        alex.williamson@redhat.com, boqun.feng@gmail.com,
        Boqun.Feng@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>
Subject: [PATCH] PCI: hv: Fix the definiton of vector in hv_compose_msi_msg()
Date:   Mon, 15 Aug 2022 11:55:05 -0700
Message-Id: <20220815185505.7626-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:303:86::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98b45f0c-c986-4360-ef02-08da7eefc8c2
X-MS-TrafficTypeDiagnostic: BY5PR21MB1393:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1AYR3mroC8JS5oqHSfUsYuro2ZjPAVUU12P6uP8Qt6Ay4ciag9wQHI2JdKpTLmBiLsBBNZjHcVsLq2PCsBJQRwultiKTueI//LAGxB1wEhikR5iTI0Wt2Z5Axkpgr7Ei4R/1TjihzU7DyYehWusJ7PpRIqcFv+jMgl7Y0z/nl8EPDuqPwFg/NvWbiobMaD8EqFjroJzBbPxcJ/tLMymm3o8oq9GgG7FJIVqgv17Qx4sMUSaKwOW869Ok2v3cRwggvAO3X6HRFPbU1+6UTuRYsA93HUxXinQGtYvT/8Oc1uD4n/SN6iBsHCa71L7qlbjl3yrnL6ouFAjCFOuO+g3T8nN4PKuPySV4zUYtoktC32N2jy0lYW8cO/Ca2SNHqlrOyPvHDmnabJpoFJ5MmN+F1P++eTCcQkgv6i/qhL9nZ+yEGE8g1BgnabbrDekxXFEDGXRE70yCHbob5cI2JNAji+ypLVgd6xepyvr+wPQWX+/I5lr7fIL14t5vQUZi1SJq1AWyh+IgdZ98NHET8xDxbCR8avMAeDnLD+o56s+8/HY694Yhfp16+zUesOAtjIULzjZonsVjOmCNZVLaHR9Kh3OEGdV42DaK4d0jmnqwaCV00AVovscxx8yu9JqjN4FZiV4VHmw65nsB3cxZzEH80BXkmJwKWlSaF08c9hS4eJD3JjTjAchAzdN2luDkQCTHr6N2fQ6PmYgRisVny92q1N5JhZYUKzz7NJ9xnd1s2GvpHn4qwSGvOPrdyr4TvRpOFo301tis7JNBMGj9xsr26i5/l/nbF8GDjIWbxj5djzY1YzJVb3jMCgJ1dAvG2HNX6+I84w4SGSzSaqinmacUA0pyHWl3Gbaj5pUdPH7rrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199009)(86362001)(6512007)(2616005)(3450700001)(2906002)(6506007)(921005)(52116002)(82950400001)(82960400001)(83380400001)(186003)(6666004)(1076003)(38100700002)(36756003)(8936002)(966005)(6486002)(316002)(478600001)(66556008)(4326008)(66946007)(8676002)(5660300002)(66476007)(41300700001)(10290500003)(6636002)(54906003)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sRCL9p5GSNFS8/fBjhm+FGYxzPSzA7tkn1XlcXHO+XnIUcdFgpxb7Gg8SvUa?=
 =?us-ascii?Q?ZzuDhUkFQWD2Z8lQ47alrMtx+x5z3F6Njik58pfyOSsYWtm7Wv/QdQPGsSf4?=
 =?us-ascii?Q?bhs5S5Eblv0qSYLZ3QLy3hnl1gO/0Z5v0Icx15/igJtqANV9ZlP+35QQ5D21?=
 =?us-ascii?Q?RfOabJcn5lxv2SezvwRpVt4VzXpfj2SM7Jrjh+lcm9i8yV4bI2CJRrYiyeMa?=
 =?us-ascii?Q?5d9GoyyxxkY3TEPnnE4VYB/yVJlpPpR14vrEzAOxZBIJiKXEqlr2vDH62tjj?=
 =?us-ascii?Q?/YwLqd4NqaaF/7BJ1mXiN4sXL0h1tMgW2YGTvDXoCqnTwADQC8LzSwgSVbDp?=
 =?us-ascii?Q?79/ClDBoVoKQ6QBmyna50sMJSttgv5zCUfGchizV+IK54GC2PVbXNKbR3pJL?=
 =?us-ascii?Q?PRHTG1weesKHG0+JhYmCQHz83PDC8YIjCa0b2Hu4SYgqLdHz/XWcLrZqGHMb?=
 =?us-ascii?Q?ceIIewGfbCOfFJJ9r5p89/pyEqXXZoyH6N2uzs5kE+Iv+v/TYJ0kIJnmYOeL?=
 =?us-ascii?Q?onPV4cs3SyIZKxDHdxuH4RUjSsElKhyCfGkCgEYviotcJU3jjRZHlog/4NNt?=
 =?us-ascii?Q?Qa505/Nj7IP5WZUSkDjPCim+gg1HUCmztyYvSk8XtOfBm8zZ6bp3OBWLvwOQ?=
 =?us-ascii?Q?8fNygJwH0YyzdE016hsU91xbvmCuqNE1iHZ9x9Eh9ue9ZuU66T+14QUfy6FX?=
 =?us-ascii?Q?IGxRH8THHEtp9GraN27ozXhNNqfCo2gh9GbMXqcNRLJ/fbecvI5ArpaESZdB?=
 =?us-ascii?Q?qdapFTV0U21egHKpDT5rCUybB/aXXh7UaV95TdA+Pbs40uQ68RBMpRkzAAHM?=
 =?us-ascii?Q?WrqNBdtR2RhrB8jILGgjfWU38xdIYxSc3l3EWsiRoVgH0Ioe066QvW4Oa9uJ?=
 =?us-ascii?Q?OeJOPmnI39VYTjfzA1ArQhMhOWHalBwphegZICXQMuHwGiePsIQ2xdHxHMum?=
 =?us-ascii?Q?vUVqD5fr71aokgUdZXz+g5Q7Zk4ia2TSwvuOr9E2j+m/htxfb++0rfdAie0Z?=
 =?us-ascii?Q?NqZkFU1Cqc8or3UgoJgHfSieKuOPbYznFrKSREAtHDhfM+kyOoo1zDfp9Rs1?=
 =?us-ascii?Q?x3TaMSCf6f8kQcifnnM9bF4d8AySR7gvKlbAX8coUiFVfHxRVzv1eVBYQzEE?=
 =?us-ascii?Q?Edl5tWZF/9m8XDwvFqiOAz6rYTWLTY24lspkoXdVBXH228sQCPIcRI9rfYSp?=
 =?us-ascii?Q?CWm3ncrvyE6HtU7mK7GwIFhU0D9zAVQRlHWHV9I61OIN1ucDknP4eSDo9Odn?=
 =?us-ascii?Q?9ytuH3WFYe04A+pRHb7ycBJHWyS9ySIhH2LT8EauLCfGe5RjitEsV+NezVRx?=
 =?us-ascii?Q?9Yz8PVFu3ZE8MjS9crVHxVBaJourUf2y7Ls3f5hHnbn0LgpTxmsSfSUff4eE?=
 =?us-ascii?Q?w1tc03ZXsQ6QrbNJnfpmFE0gCaOuw4J0WfdPxI6NY5vvo1po6ta7SPVUBTtm?=
 =?us-ascii?Q?/h4jCotUmy/CkldgYGcn6roHZNVYP40W1mx1eLf1hiOP9XydoonAsDOVCRA/?=
 =?us-ascii?Q?1vOOKu9iIW42m1Q9urhC8m4aaeDM/I8ewue5jfpPALzlVe76+4UYY0nbio3u?=
 =?us-ascii?Q?yKvUO07n0BveBT5LGHy0Zp7RFAZC8qeZJdisrNDPBNXN8ZJpKBhaJg/ZBRAY?=
 =?us-ascii?Q?NRMXgqV0jxt3wgbnsvaTbUeAEf4gWYhVXUO+bsSrOw5T?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1393
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The local variable 'vector' must be u32 rather than u8: see the
struct hv_msi_desc3.

'vector_count' should be u16 rather than u8: see struct hv_msi_desc,
hv_msi_desc2 and hv_msi_desc3.

Fixes: a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Carl Vanderlip <quic_carlv@quicinc.com>
---

The patch should be appplied after the earlier patch:
    [PATCH] PCI: hv: Only reuse existing IRTE allocation for Multi-MSI
    https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui%40microsoft.com/

 drivers/pci/controller/pci-hyperv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 65d0dab25deb..53580899c859 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1614,7 +1614,7 @@ static void hv_pci_compose_compl(void *context, struct pci_response *resp,
 
 static u32 hv_compose_msi_req_v1(
 	struct pci_create_interrupt *int_pkt, struct cpumask *affinity,
-	u32 slot, u8 vector, u8 vector_count)
+	u32 slot, u8 vector, u16 vector_count)
 {
 	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE;
 	int_pkt->wslot.slot = slot;
@@ -1642,7 +1642,7 @@ static int hv_compose_msi_req_get_cpu(struct cpumask *affinity)
 
 static u32 hv_compose_msi_req_v2(
 	struct pci_create_interrupt2 *int_pkt, struct cpumask *affinity,
-	u32 slot, u8 vector, u8 vector_count)
+	u32 slot, u8 vector, u16 vector_count)
 {
 	int cpu;
 
@@ -1661,7 +1661,7 @@ static u32 hv_compose_msi_req_v2(
 
 static u32 hv_compose_msi_req_v3(
 	struct pci_create_interrupt3 *int_pkt, struct cpumask *affinity,
-	u32 slot, u32 vector, u8 vector_count)
+	u32 slot, u32 vector, u16 vector_count)
 {
 	int cpu;
 
@@ -1702,7 +1702,8 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	struct tran_int_desc *int_desc;
 	struct msi_desc *msi_desc;
 	bool multi_msi;
-	u8 vector, vector_count;
+	u32 vector; /* Must be u32: see the struct hv_msi_desc3 */
+	u16 vector_count;
 	struct {
 		struct pci_packet pci_pkt;
 		union {
-- 
2.25.1

