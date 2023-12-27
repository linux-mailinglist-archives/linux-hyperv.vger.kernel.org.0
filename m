Return-Path: <linux-hyperv+bounces-1367-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE6881EBF1
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Dec 2023 04:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73B41F2193A
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Dec 2023 03:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1B65220;
	Wed, 27 Dec 2023 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t8EHj5fR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D33C36
	for <linux-hyperv@vger.kernel.org>; Wed, 27 Dec 2023 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eV8V50F7vTNRlGDLE1wqdM+hQFiNLdCrpToiyx4ar/OhkW26ifoxqG1NkWgu93tj+i8HJGDUVATwOoF9HFMVGkgqLaF3zwnj/scXcQPetHebxCNqjCp3i1kyMLYizvYg8rWpYLGI4AUb8up4xfNqJOPGrK3Mom1HI7scOkMDNvyGYyPD0cyXydFndFqsYj0xzg7qWlNSExRJavZfcKksWXuqXh1lvoeuiij7rNUD5LfUnpkQH+HJOMc7pKbfnwODHgeRK6r9486KKGtUyw3g+xI6xmuo/FFL1XKmZcLvlJOYbz9jfneUf6+4rlGdYLWA5cXq4BzQaojO8cB4nN5QOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYn7tdVPl5INE2xpsEExhFKLlHMTWK8Lplqgl+btCb4=;
 b=UzL3ltdKEYA/AvjFzEBNAGQ1QVYu7wey9jq+3woLHW1TC8zJ3MPiXNp05tINFSO35DP6yT7rTXmgb4DxmOVIrRzSffaVUtnnW8coFgbZ4yzCvC7LskwP/YdTsXyoaA81WqooWqajhDRhPv9HFWGefWNCbAJ28JlMZ7jgx1xy26XEKIraa5xkzkxCts4FDeHfwCmGUxP6Xahh7FHv9+9uFu0meJ9onsd8SQnOcptrc2suKf2VCJvHRrlnX4tLyB9/rssrgn+m7RI3CsPEQComC+ivZ5WsWhqraXFsGgz/yRRdN2ICan3G71nctnGdOm92RziWn+9b2SpLdMu0vq7DFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.microsoft.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYn7tdVPl5INE2xpsEExhFKLlHMTWK8Lplqgl+btCb4=;
 b=t8EHj5fR1i9m9M9elgzUGeHjssFz4fUUkXDsuoP//Cs9uDRTE7iL4DACFx3uMVR3+1yQdNts68xt406qr4QurTbYd/8bVV79AYH4NZxBgcuYPdUkZUevwFXRIjqJUNZQHRlejaLSpRUgbycq/bJNaHW2DWWeVE8aT0G9HC9oz7k=
Received: from SJ0PR13CA0058.namprd13.prod.outlook.com (2603:10b6:a03:2c2::33)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 03:50:22 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::73) by SJ0PR13CA0058.outlook.office365.com
 (2603:10b6:a03:2c2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18 via Frontend
 Transport; Wed, 27 Dec 2023 03:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Wed, 27 Dec 2023 03:50:22 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 26 Dec
 2023 21:50:20 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: Iouri Tarassov <iourit@linux.microsoft.com>
CC: <linux-hyperv@vger.kernel.org>, Lang Yu <Lang.Yu@amd.com>
Subject: [PATCH] drivers: hv: dxgkrnl: Allow user to specify CPU VA for device allocation
Date: Wed, 27 Dec 2023 11:49:50 +0800
Message-ID: <20231227034950.1975922-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e1c54a-0056-430e-68dd-08dc068ef3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iwxtj16pXroRUogHc01hzvx7TJLrdmJxfSkT+mgIzYAT4AHQALPN/86UIptDK+hYV5EpQKY5rRsHV3PA9NQJpcLafKc9JqwMiiMFbSFLm204WNbF+g40QgbkVkHrPPa40xMOvG0qIQI2aySqo/teHB+tHlUprp6Cmnct1h1Bkc0U70HszIx4cRBFbEXLcCe0rSUo/hS8fT2cQ176zIFUa7syT77xfJ7Un7hAQ65LIGJa4eVkxJCNMEyzCbx862WqeZk1aA8j3zuX5TglvLehhgxhdMj5itH9iDFHp/Zi4a1nXpUN8nxIGiHmzapIEZANjbGvBUVpbCU+G7iWprm4EA0ZSUIbP6zC947aIbcfqmak/fb9O6J1wNoko2FkZMEhK+YvZNwhzYvGkBkApmVek/VMBCjGYJ7ES4LTRLdpMOiszw/N9Yy3mLm8N9NPxVele2JhaXX51oTmHz8anOgm02WndL2FaLBrWbLdDwz3xk00wP8WtA9LLCSgqNppHVpQgXbT6peCgmlvipdJEpE6q9zvd84bpOWFTPTVj+YtkzBUHOLnfbBLeBA9AcxlLZWucWPSt+WfF3RC8my9mdlcae/03JnGjvJyLfwNsp4DJQG8hEsi1TaujACt/VLrCL1fLH64/mW3xOP+zaQ/BXoE4nsWyAypujtJ06JWyZSNXr+GxyIIMGHbXUFy2sqpNE0bqF45OW6rHbN9b2uHxyLpey88TmaawxmOcXCreH7bVgaTPFG5v6Wb/ydpD2l9N3p0snSR1z9EUs7r6a1HjGe6G6TpMpl9+vbnMm0gAMn7+ZU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(1800799012)(64100799003)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(1076003)(2616005)(336012)(16526019)(426003)(26005)(316002)(4326008)(8676002)(41300700001)(8936002)(2906002)(86362001)(6916009)(5660300002)(478600001)(70586007)(70206006)(36756003)(54906003)(6666004)(7696005)(82740400003)(356005)(81166007)(47076005)(40480700001)(36860700001)(83380400001)(40460700003)(133343001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 03:50:22.3703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e1c54a-0056-430e-68dd-08dc068ef3c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862

The movtivation is we want to unify CPU VA and GPU VA.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/hv/dxgkrnl/dxgvmbus.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 9320bede3a0a..a4bca27a7cc8 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -580,7 +580,7 @@ int dxg_unmap_iospace(void *va, u32 size)
 	return 0;
 }
 
-static u8 *dxg_map_iospace(u64 iospace_address, u32 size,
+static u8 *dxg_map_iospace(u64 iospace_address, u64 user_va, u32 size,
 			   unsigned long protection, bool cached)
 {
 	struct vm_area_struct *vma;
@@ -594,7 +594,12 @@ static u8 *dxg_map_iospace(u64 iospace_address, u32 size,
 		return NULL;
 	}
 
-	va = vm_mmap(NULL, 0, size, protection, MAP_SHARED | MAP_ANONYMOUS, 0);
+	if (user_va)
+		va = vm_mmap(untagged_addr(user_va), 0, size, protection,
+			     MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, 0);
+	else
+		va = vm_mmap(NULL, 0, size, protection,
+			     MAP_SHARED | MAP_ANONYMOUS, 0);
 	if ((long)va <= 0) {
 		DXG_ERR("vm_mmap failed %lx %d", va, size);
 		return NULL;
@@ -789,9 +794,8 @@ int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
 
 	args->sync_object = result.sync_object;
 	if (syncobj->monitored_fence) {
-		void *va = dxg_map_iospace(result.guest_cpu_physical_address,
-					   PAGE_SIZE, PROT_READ | PROT_WRITE,
-					   true);
+		void *va = dxg_map_iospace(result.guest_cpu_physical_address, 0,
+					   PAGE_SIZE, PROT_READ | PROT_WRITE, true);
 		if (va == NULL) {
 			ret = -ENOMEM;
 			goto cleanup;
@@ -1315,8 +1319,8 @@ int dxgvmb_send_create_paging_queue(struct dxgprocess *process,
 	args->paging_queue = result.paging_queue;
 	args->sync_object = result.sync_object;
 	args->fence_cpu_virtual_address =
-	    dxg_map_iospace(result.fence_storage_physical_address, PAGE_SIZE,
-			    PROT_READ | PROT_WRITE, true);
+	    dxg_map_iospace(result.fence_storage_physical_address, 0,
+			    PAGE_SIZE, PROT_READ | PROT_WRITE, true);
 	if (args->fence_cpu_virtual_address == NULL) {
 		ret = -ENOMEM;
 		goto cleanup;
@@ -2867,7 +2871,7 @@ dxgvmb_send_create_sync_object(struct dxgprocess *process,
 	}
 
 	if (syncobj->monitored_fence) {
-		va = dxg_map_iospace(result.fence_storage_address, PAGE_SIZE,
+		va = dxg_map_iospace(result.fence_storage_address, 0, PAGE_SIZE,
 				     PROT_READ | PROT_WRITE, true);
 		if (va == NULL) {
 			ret = -ENOMEM;
@@ -3156,7 +3160,7 @@ int dxgvmb_send_lock2(struct dxgprocess *process,
 		} else {
 			u64 offset = (u64)result.cpu_visible_buffer_offset;
 
-			args->data = dxg_map_iospace(offset,
+			args->data = dxg_map_iospace(offset, args->data,
 					alloc->num_pages << PAGE_SHIFT,
 					PROT_READ | PROT_WRITE, alloc->cached);
 			if (args->data) {
@@ -3712,7 +3716,7 @@ int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 	}
 
 	hwqueue->progress_fence_mapped_address =
-		dxg_map_iospace((u64)command->hwqueue_progress_fence_cpuva,
+		dxg_map_iospace((u64)command->hwqueue_progress_fence_cpuva, 0,
 				PAGE_SIZE, PROT_READ | PROT_WRITE, true);
 	if (hwqueue->progress_fence_mapped_address == NULL) {
 		ret = -ENOMEM;
-- 
2.25.1


