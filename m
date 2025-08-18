Return-Path: <linux-hyperv+bounces-6545-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2287B299E9
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Aug 2025 08:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02F03A603F
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Aug 2025 06:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B5D275B1B;
	Mon, 18 Aug 2025 06:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S1ofeuAZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2B0275AFB
	for <linux-hyperv@vger.kernel.org>; Mon, 18 Aug 2025 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499313; cv=none; b=ato3zWNn89vgzzC1ds/W7R9Lf4X5UDWlLnQAAl12VDtp9yKldqqklKY4R6F6kACft/VRmyjDshQKJPwQYm+xx0UJmGNtAvCNGQsQNCi4Qp90pHjTdqzfdD4pjblG79zQ7+0/s4zAIlP/FcFkTGiWbDyYLTf788yamxW2VU5AfDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499313; c=relaxed/simple;
	bh=4EBVhoBFeF7pNGClKVleaoGFSm/cPIuw0WEv7H0jc9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hr8vxwrfJNxvf9OT6hMGt2bKCeshNIaM/lbHFhbXz0IN9bSb9D+18oRMvaNc6W+zoAsZl++SvAC9+FYJt0Fp0sK9SnUimi9UL/2yOFIANHVDhtMeF3oyDHpG9cHnT90V3vAZpsLGGOCfUHLRrWJM1ywmzfdDG4f36eVPtXrvA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S1ofeuAZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HL0GfZ029844
	for <linux-hyperv@vger.kernel.org>; Mon, 18 Aug 2025 06:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=l8N9ttvKyCBAcyEDvuaLoM
	1BSXehm0oCXcCPSraNLCM=; b=S1ofeuAZEvausPNcfPdvnKZWbPTOWDSn/I7BEC
	fEzcKChFEREcdnUgDUZ0liwYbWKPM8rZPt1QO6jTgcF7psCTS7i5PGkOE6QI5JZ+
	KHyXq3fCcqVTX2TNJW8aE6hSDVQ07wo13XXPL6m308u3dn1gS4TZLJGYH+UVZxaP
	N5c049QcgEAx92YW7CGLG4srnZufUn6OZjs+cmknhQDuglZbtyx7y+zif+BWwBD5
	rLKoMV37K5sMLFRlSxJZfA3l9dBzOODYODOqjuY6k3pCnQT61mXkUULbWa5h5/21
	Fb+5mmW8neh+DKoOx0rQ8WtgQ3aJv0kjv4N5E7mgkhK3nJmQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjrfugjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Mon, 18 Aug 2025 06:41:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244581c62faso38545865ad.2
        for <linux-hyperv@vger.kernel.org>; Sun, 17 Aug 2025 23:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755499310; x=1756104110;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8N9ttvKyCBAcyEDvuaLoM1BSXehm0oCXcCPSraNLCM=;
        b=sTxD/GSRjeTJcINk7LDyGMxDZ2HzOgCB4Ut0BaTnJS/N7apoKM7BflzTjhsYTPOI5Y
         EEQgcNLbOk75YGWGx0Tp/JJa3a7euSOKv42bT3rYQ2tDjadakuNNSdgfKdo37ZpG72FD
         5/nzJHOHYGc9ret4uhTuNp7R2GgLyQSC92MngnG/5zuRuth4UoGsaqRF+b/NCn8WoytN
         fwK0We9MCiAzsqZvJiHh+zK6MaSCjbCTi5YhRPhvnMRTlaoPELIh5Mlco+KpEY4QVwxP
         pJJbcUHjQ+IDubGdAJ76g0JYFFmadFBVvrtkZLK4yIfpP4drHqp59jhXIym9vV6mJlCq
         FlbA==
X-Forwarded-Encrypted: i=1; AJvYcCU6Q6zyrt56pbq4lQgU9kZbann9LrLhrLB8+BNjhQnBJRghd13gHTyTATBoNX1l8kcvoxv+z3vgNK10dvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxevW92HBO/HBgyU1OPMvsOSOinYqNNsFQbSdOrfv7aR0hA1N5K
	HZrxFKTCdF9rwaluyhF3N9zvDxU5bFnUouPzV+FGHOjowb6gR6BvZCy9pJ7zzhRvf1MOVFxeFUj
	dXtyLn/1xwV2/bk0wM9ruLxHzCt4R0mALFSMlyqX8kpnOL+jHPAiJ9a4n1Bh+B41kAW8=
X-Gm-Gg: ASbGncvrVf4+sKKWOdnlXUl07mQclME4e1RPhPz+DsXFC3MVLEayy3bV4VhH2eic2tr
	+feN3wBgOlunBNxc0IYkf1NDBxbIPycDJayai9aL9Z/V4knVy4+4DWlwXVgQil4sOrXakVTwqYV
	yi2Q2C6s11Vvk6F7MByagAF9d03PoN/clZGfTWwAOaHoaf0PK+69q4yxCUD+fY0gnlZDglpHoAX
	tFZHhptI2yB6qP6WGOOWM6keirORzwK2lVOwT1Lm/wH9rZ3kLFd8iVDnaQAxsvnIbBGAd91A8rg
	goxBjdWwSfgmljprgIvwFA7w2jNixUc9uDHuGxbvjDk=
X-Received: by 2002:a17:902:c951:b0:240:22af:91c7 with SMTP id d9443c01a7336-2446d71db3fmr134372835ad.14.1755499310172;
        Sun, 17 Aug 2025 23:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmF5KBA9eIDDl75sJwjMQCpOEjZ8TR6DA+JYR6yCjrU7iJmsnLTLQaYA9/NFl8UsVIfaN9mw==
X-Received: by 2002:a17:902:c951:b0:240:22af:91c7 with SMTP id d9443c01a7336-2446d71db3fmr134372375ad.14.1755499309632;
        Sun, 17 Aug 2025 23:41:49 -0700 (PDT)
Received: from hu-pbrahma-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53bf5dsm70069295ad.114.2025.08.17.23.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:41:48 -0700 (PDT)
From: pratyush.brahma@oss.qualcomm.com
X-Google-Original-From: Pratyush
Date: Mon, 18 Aug 2025 12:11:15 +0530
Subject: [PATCH] mm/numa: Rename memory_add_physaddr_to_nid to
 memory_get_phys_to_nid
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-numa_memblks-v1-1-9eb29ade560a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAArLomgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0MT3bzS3MT43NTcpJzsYt0kU5NEC3MLCyODlFQloJaCotS0zAqwcdG
 xQH5GZnFJflElyPTa2loAgXpdgW0AAAA=
X-Change-ID: 20250814-numa_memblks-b54a878820de
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-acpi@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org, linux-cxl@vger.kernel.org,
        linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
        xen-devel@lists.xenproject.org,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755499297; l=12122;
 i=pratyush.brahma@oss.qualcomm.com; s=20250808; h=from:subject:message-id;
 bh=//n/Cd8/21p2TwuLHbKJjrZr/VX2C3LDE0HHjeHcn3A=;
 b=YhwC5Lk4afAnAuPN/u4jW8oYab0ctCO2cz+geSxr4bRuihGdwIV2yM1kuCXBVrnF+tdcuoDdH
 v7S65fFa5CkAcFfEgaPVnJ6mv1qtlUNsSBr4p0Efj25v9textGh8WHy
X-Developer-Key: i=pratyush.brahma@oss.qualcomm.com; a=ed25519;
 pk=ZeXF1N8hxU6j3G/ajMI+du/TVXMZQaXDwnJyznB69ms=
X-Proofpoint-GUID: _dC4LlDeEFkzfxaBwHlF6ssw60NBYi54
X-Authority-Analysis: v=2.4 cv=YrsPR5YX c=1 sm=1 tr=0 ts=68a2cb2f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=qb4DzySmTAYQGscL8MYA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzOSBTYWx0ZWRfX+z7KVQMaHHaE
 GKQqDOR3mfZkkucVjSRSu2qaIZhMU55mqrmttKrbzljekjJ0tjJFCmwDKWgP9s7kBkU/2qHvQO1
 midF8tv1JDieczGjC3mnNbIF5MPMkP20CUoCtHKIYXn3zjY0JPUM/sL1RbUSUQAFgwluN1jNjr5
 SUUXOW1mOHqt5ot9J+EUE8rQkMi2DSI9QiwEuFXklabQxRF4PVgQDFueQOnrAk/K39Wcr8UbwTM
 kWCTDDgn2lCaz+vdddP4R9DTZVwvEsxP9O1f0bFOZDhONna7xjIkSNwkuuoq7jJmWmtU9jhuiJ4
 6EiaxZZIg30bBkf+OaFpRnFjLTJYPF9omO+yqRigilZr2MIidWHDnI2RmBWYchYa2jTYb3yvbkb
 Ny1MWus4
X-Proofpoint-ORIG-GUID: _dC4LlDeEFkzfxaBwHlF6ssw60NBYi54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1011 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160039

From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>

The function `memory_add_physaddr_to_nid` seems a misnomer.
It does not to "add" a physical address to a NID mapping,
but rather it gets the NID associated with a given physical address.

Improve the semantic clarity of the API by renaming to a more
descriptive name.

Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
---
 arch/powerpc/include/asm/sparsemem.h | 4 ++--
 arch/powerpc/mm/mem.c                | 4 ++--
 arch/s390/include/asm/sparsemem.h    | 4 ++--
 drivers/acpi/acpi_memhotplug.c       | 2 +-
 drivers/acpi/nfit/core.c             | 2 +-
 drivers/base/memory.c                | 2 +-
 drivers/cxl/pmem.c                   | 2 +-
 drivers/dax/cxl.c                    | 2 +-
 drivers/hv/hv_balloon.c              | 6 +++---
 drivers/nvdimm/virtio_pmem.c         | 2 +-
 drivers/virtio/virtio_mem.c          | 2 +-
 drivers/xen/balloon.c                | 2 +-
 include/linux/numa.h                 | 6 +++---
 include/linux/numa_memblks.h         | 4 ++--
 mm/numa.c                            | 6 +++---
 mm/numa_memblks.c                    | 4 ++--
 16 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index d072866842e4229159fcb6635745fd19a2788413..cdb5594616c8e32ab8ae3d209d0b2df20f3564f6 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -14,8 +14,8 @@
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern int remove_section_mapping(unsigned long start, unsigned long end);
-extern int memory_add_physaddr_to_nid(u64 start);
-#define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+extern int memory_get_phys_to_nid(u64 start);
+#define memory_get_phys_to_nid memory_get_phys_to_nid
 
 #ifdef CONFIG_NUMA
 extern int hot_add_scn_to_nid(unsigned long scn_addr);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 3ddbfdbfa9413a17d8321885724ce432d967005a..5665b2e2fc68df8634613c11706e1a9158a3a616 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -54,11 +54,11 @@ EXPORT_SYMBOL(__phys_mem_access_prot);
 static DEFINE_MUTEX(linear_mapping_mutex);
 
 #ifdef CONFIG_NUMA
-int memory_add_physaddr_to_nid(u64 start)
+int memory_get_phys_to_nid(u64 start)
 {
 	return hot_add_scn_to_nid(start);
 }
-EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
+EXPORT_SYMBOL_GPL(memory_get_phys_to_nid);
 #endif
 
 int __weak create_section_mapping(unsigned long start, unsigned long end,
diff --git a/arch/s390/include/asm/sparsemem.h b/arch/s390/include/asm/sparsemem.h
index 668dfc5de538742269af1b25151372506105fd4d..744c67dce4c106d063cb5436b37412045da0fd2a 100644
--- a/arch/s390/include/asm/sparsemem.h
+++ b/arch/s390/include/asm/sparsemem.h
@@ -7,11 +7,11 @@
 
 #ifdef CONFIG_NUMA
 
-static inline int memory_add_physaddr_to_nid(u64 addr)
+static inline int memory_get_phys_to_nid(u64 addr)
 {
 	return 0;
 }
-#define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+#define memory_get_phys_to_nid memory_get_phys_to_nid
 
 static inline int phys_to_target_node(u64 start)
 {
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index d0c1a71007d0a3054608bec8fddc8e86bdffb78b..6f968243ffc3cc5864e73b914d1bf67748e30e66 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -183,7 +183,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 			continue;
 		/* We want a single node for the whole memory group */
 		if (node < 0)
-			node = memory_add_physaddr_to_nid(info->start_addr);
+			node = memory_get_phys_to_nid(info->start_addr);
 		total_length += info->length;
 	}
 
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index ae035b93da087812dee6ec47d9ef4aa97dc8e7bc..04c3ab311e4d5923aef50252efabd193c5fb7850 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2630,7 +2630,7 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
 
 	/* Fallback to address based numa information if node lookup failed */
 	if (ndr_desc->numa_node == NUMA_NO_NODE) {
-		ndr_desc->numa_node = memory_add_physaddr_to_nid(spa->address);
+		ndr_desc->numa_node = memory_get_phys_to_nid(spa->address);
 		dev_info(acpi_desc->dev, "changing numa node from %d to %d for nfit region [%pa-%pa]",
 			NUMA_NO_NODE, ndr_desc->numa_node, &res.start, &res.end);
 	}
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 5c6c1d6bb59f1241a5f42a3396be1a8e2058c965..f657520855408804761afec379e3c0b2a238b239 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -599,7 +599,7 @@ static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	nid = memory_add_physaddr_to_nid(phys_addr);
+	nid = memory_get_phys_to_nid(phys_addr);
 	ret = __add_memory(nid, phys_addr,
 			   MIN_MEMORY_BLOCK_SIZE * sections_per_block,
 			   MHP_NONE);
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index e197883690efc11f60c31bd56aeb5695665d422b..471aed4e11241948e994d0b9d53600c147e38fb0 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -410,7 +410,7 @@ static int cxl_pmem_region_probe(struct device *dev)
 	ndr_desc.res = res;
 	ndr_desc.provider_data = cxlr_pmem;
 
-	ndr_desc.numa_node = memory_add_physaddr_to_nid(res->start);
+	ndr_desc.numa_node = memory_get_phys_to_nid(res->start);
 	ndr_desc.target_node = phys_to_target_node(res->start);
 	if (ndr_desc.target_node == NUMA_NO_NODE) {
 		ndr_desc.target_node = ndr_desc.numa_node;
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 13cd94d32ff7a1d70af7821c1aecd7490302149d..35843791872ba466f571c022e1484816368a1198 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -15,7 +15,7 @@ static int cxl_dax_region_probe(struct device *dev)
 	struct dev_dax_data data;
 
 	if (nid == NUMA_NO_NODE)
-		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
+		nid = memory_get_phys_to_nid(cxlr_dax->hpa_range.start);
 
 	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
 				      PMD_SIZE, IORESOURCE_DAX_KMEM);
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 2b4080e51f97c30e7adb06faa56b1403bc08b53c..8878aac6da9cd3bd6f499eae2588e989b7219af3 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -725,7 +725,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 
 		reinit_completion(&dm_device.ol_waitevent);
 
-		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
+		nid = memory_get_phys_to_nid(PFN_PHYS(start_pfn));
 		ret = add_memory(nid, PFN_PHYS((start_pfn)),
 				 HA_BYTES_IN_CHUNK, MHP_MERGE_RESOURCE);
 
@@ -1701,8 +1701,8 @@ static int hot_add_enabled(void)
 {
 	/*
 	 * Disable hot add on ARM64, because we currently rely on
-	 * memory_add_physaddr_to_nid() to get a node id of a hot add range,
-	 * however ARM64's memory_add_physaddr_to_nid() always return 0 and
+	 * memory_get_phys_to_nid() to get a node id of a hot add range,
+	 * however ARM64's memory_get_phys_to_nid() always return 0 and
 	 * DM_MEM_HOT_ADD_REQUEST doesn't have the NUMA node information for
 	 * add_memory().
 	 */
diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 2396d19ce5496974f8b93b54cc8c95e48dda103d..df6a3fd552d11a577d85708f80e7558ea83839d2 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -100,7 +100,7 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 
 	ndr_desc.res = &res;
 
-	ndr_desc.numa_node = memory_add_physaddr_to_nid(res.start);
+	ndr_desc.numa_node = memory_get_phys_to_nid(res.start);
 	ndr_desc.target_node = phys_to_target_node(res.start);
 	if (ndr_desc.target_node == NUMA_NO_NODE) {
 		ndr_desc.target_node = ndr_desc.numa_node;
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 1688ecd69a0445d5c21d108a9a1d60577f96d7ac..6154f03a12c3efa65728f626e43b6270245d439c 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2858,7 +2858,7 @@ static int virtio_mem_init(struct virtio_mem *vm)
 
 	/* Determine the nid for the device based on the lowest address. */
 	if (vm->nid == NUMA_NO_NODE)
-		vm->nid = memory_add_physaddr_to_nid(vm->addr);
+		vm->nid = memory_get_phys_to_nid(vm->addr);
 
 	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
 	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 2de37dcd75566fc1a03b75232cbe17fc0f53909d..93ca270ddd516ec11bc3f096eb518b9789d92664 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -284,7 +284,7 @@ static enum bp_state reserve_additional_memory(void)
 	if (!resource)
 		goto err;
 
-	nid = memory_add_physaddr_to_nid(resource->start);
+	nid = memory_get_phys_to_nid(resource->start);
 
 #ifdef CONFIG_XEN_HAVE_PVMMU
 	/*
diff --git a/include/linux/numa.h b/include/linux/numa.h
index e6baaf6051bcff6c23308d3b67f790053fbd29dc..ed65a20f39718a5a3157f6f9db60561f4418b000 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -33,8 +33,8 @@ int numa_nearest_node(int node, unsigned int state);
 
 int nearest_node_nodemask(int node, nodemask_t *mask);
 
-#ifndef memory_add_physaddr_to_nid
-int memory_add_physaddr_to_nid(u64 start);
+#ifndef memory_get_phys_to_nid
+int memory_get_phys_to_nid(u64 start);
 #endif
 
 #ifndef phys_to_target_node
@@ -54,7 +54,7 @@ static inline int nearest_node_nodemask(int node, nodemask_t *mask)
 	return NUMA_NO_NODE;
 }
 
-static inline int memory_add_physaddr_to_nid(u64 start)
+static inline int memory_get_phys_to_nid(u64 start)
 {
 	return 0;
 }
diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
index 991076cba7c5016d845eb40a2f9887f73fa83862..37cc0987e738f8aa2eb5c8f1ca2c94394def4780 100644
--- a/include/linux/numa_memblks.h
+++ b/include/linux/numa_memblks.h
@@ -53,8 +53,8 @@ static inline int numa_emu_cmdline(char *str)
 #ifdef CONFIG_NUMA_KEEP_MEMINFO
 extern int phys_to_target_node(u64 start);
 #define phys_to_target_node phys_to_target_node
-extern int memory_add_physaddr_to_nid(u64 start);
-#define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+extern int memory_get_phys_to_nid(u64 start);
+#define memory_get_phys_to_nid memory_get_phys_to_nid
 #endif /* CONFIG_NUMA_KEEP_MEMINFO */
 
 #endif /* CONFIG_NUMA_MEMBLKS */
diff --git a/mm/numa.c b/mm/numa.c
index 7d5e06fe5bd4a2790b83dd7dbe646617f6476d8c..f7b5ac8aea608368b75c606970187eb147ddf427 100644
--- a/mm/numa.c
+++ b/mm/numa.c
@@ -40,14 +40,14 @@ void __init alloc_offline_node_data(int nid)
 
 /* Stub functions: */
 
-#ifndef memory_add_physaddr_to_nid
-int memory_add_physaddr_to_nid(u64 start)
+#ifndef memory_get_phys_to_nid
+int memory_get_phys_to_nid(u64 start)
 {
 	pr_info_once("Unknown online node for memory at 0x%llx, assuming node 0\n",
 			start);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
+EXPORT_SYMBOL_GPL(memory_get_phys_to_nid);
 #endif
 
 #ifndef phys_to_target_node
diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index 541a99c4071a67e5b0ef66f4136dee268a880003..346039bd933390fb014931fc61ccd2f96a773c37 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -580,7 +580,7 @@ int phys_to_target_node(u64 start)
 }
 EXPORT_SYMBOL_GPL(phys_to_target_node);
 
-int memory_add_physaddr_to_nid(u64 start)
+int memory_get_phys_to_nid(u64 start)
 {
 	int nid = meminfo_to_nid(&numa_meminfo, start);
 
@@ -588,6 +588,6 @@ int memory_add_physaddr_to_nid(u64 start)
 		nid = numa_meminfo.blk[0].nid;
 	return nid;
 }
-EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
+EXPORT_SYMBOL_GPL(memory_get_phys_to_nid);
 
 #endif /* CONFIG_NUMA_KEEP_MEMINFO */

---
base-commit: 479058002c32b77acac43e883b92174e22c4be2d
change-id: 20250814-numa_memblks-b54a878820de

Best regards,
-- 
Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>


