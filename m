Return-Path: <linux-hyperv+bounces-8649-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFoYKrzngGleCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8649-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 19:06:52 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B068CFECB
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 19:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5034309D900
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 17:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9752338947A;
	Mon,  2 Feb 2026 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EtHzrdKF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F90C389473;
	Mon,  2 Feb 2026 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055145; cv=none; b=bEv7m8YpseEst1ipD/nSMECaKKz47UTCbiyFmLVoZkEfvXPyTJNgxqNlV9PWLc3HSo96d3uyTiqinhxz2oLxXgmexuVMHvEDtOAeohCjP0nZU90G8lvCdhbALRX4xBmyFR97nslvnCIy4YQacnAwf4/JZsvSSzMeERWl2yJePkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055145; c=relaxed/simple;
	bh=L5xw7aLrJgwEvLotODEI4qEe4bURXelleK+Vn5JyQR4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJUdDmJdOhX91Z5xWQrCHrymgbhDUasRACEr+wiGEYZX1yMJvSFN4FpAOcuPRjyhaLQpkOK7GBZgZCO0HKiPd+0RPjijAnRHuHTfJ886T35CMXnhekV33FjkKL6xYT8NrKBKNT0th5TJHUF/dyicV229eE+uwV356Zyx94gMnwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EtHzrdKF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id D3C5B20B7168;
	Mon,  2 Feb 2026 09:59:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3C5B20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770055143;
	bh=GljZGoX9xaZN1R6PTWTaTHBbPQR+fTQhPZUAsqH37Ck=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EtHzrdKFAj3agDuK0K7iXx3n8eCYTNzXNcojAu6Pk7xEHDKP1LZ0zvi36iKxn/8HA
	 IiXaFXUBvC8bLz3dqe+naKjQ5EohUFzsE0AigVLqOK7NAN5tZk7FLckWTisL3U8rpm
	 q/OApy5EbieAmabFyo942pGkKGy7EBCadZbyA9e0=
Subject: [PATCH v2 2/4] mshv: Introduce hv_deposit_memory helper functions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Feb 2026 17:59:03 +0000
Message-ID: 
 <177005514346.120041.5702271891856790910.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8649-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B068CFECB
X-Rspamd-Action: no action

Introduce hv_deposit_memory_node() and hv_deposit_memory() helper
functions to handle memory deposition with proper error handling.

The new hv_deposit_memory_node() function takes the hypervisor status
as a parameter and validates it before depositing pages. It checks for
HV_STATUS_INSUFFICIENT_MEMORY specifically and returns an error for
unexpected status codes.

This is a precursor patch to new out-of-memory error codes support.
No functional changes intended.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/hv_proc.c           |   22 ++++++++++++++++++++--
 drivers/hv/mshv_root_hv_call.c |   25 +++++++++----------------
 drivers/hv/mshv_root_main.c    |    3 +--
 include/asm-generic/mshyperv.h |   10 ++++++++++
 4 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index e53204b9e05d..ffa25cd6e4e9 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -110,6 +110,23 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 }
 EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
 
+int hv_deposit_memory_node(int node, u64 partition_id,
+			   u64 hv_status)
+{
+	u32 num_pages;
+
+	switch (hv_result(hv_status)) {
+	case HV_STATUS_INSUFFICIENT_MEMORY:
+		num_pages = 1;
+		break;
+	default:
+		hv_status_err(hv_status, "Unexpected!\n");
+		return -ENOMEM;
+	}
+	return hv_call_deposit_pages(node, partition_id, num_pages);
+}
+EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
+
 bool hv_result_needs_memory(u64 status)
 {
 	switch (hv_result(status)) {
@@ -155,7 +172,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 			}
 			break;
 		}
-		ret = hv_call_deposit_pages(node, hv_current_partition_id, 1);
+		ret = hv_deposit_memory_node(node, hv_current_partition_id,
+					     status);
 	} while (!ret);
 
 	return ret;
@@ -197,7 +215,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 			}
 			break;
 		}
-		ret = hv_call_deposit_pages(node, partition_id, 1);
+		ret = hv_deposit_memory_node(node, partition_id, status);
 
 	} while (!ret);
 
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 89afeeda21dd..174431cb5e0e 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -123,8 +123,7 @@ int hv_call_create_partition(u64 flags,
 			break;
 		}
 		local_irq_restore(irq_flags);
-		ret = hv_call_deposit_pages(NUMA_NO_NODE,
-					    hv_current_partition_id, 1);
+		ret = hv_deposit_memory(hv_current_partition_id, status);
 	} while (!ret);
 
 	return ret;
@@ -151,7 +150,7 @@ int hv_call_initialize_partition(u64 partition_id)
 			ret = hv_result_to_errno(status);
 			break;
 		}
-		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
+		ret = hv_deposit_memory(partition_id, status);
 	} while (!ret);
 
 	return ret;
@@ -465,8 +464,7 @@ int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
 		}
 		local_irq_restore(flags);
 
-		ret = hv_call_deposit_pages(NUMA_NO_NODE,
-					    partition_id, 1);
+		ret = hv_deposit_memory(partition_id, status);
 	} while (!ret);
 
 	return ret;
@@ -525,8 +523,7 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
 		}
 		local_irq_restore(flags);
 
-		ret = hv_call_deposit_pages(NUMA_NO_NODE,
-					    partition_id, 1);
+		ret = hv_deposit_memory(partition_id, status);
 	} while (!ret);
 
 	return ret;
@@ -573,7 +570,7 @@ static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 
 		local_irq_restore(flags);
 
-		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
+		ret = hv_deposit_memory(partition_id, status);
 	} while (!ret);
 
 	return ret;
@@ -722,8 +719,7 @@ hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
 			ret = hv_result_to_errno(status);
 			break;
 		}
-		ret = hv_call_deposit_pages(NUMA_NO_NODE, port_partition_id, 1);
-
+		ret = hv_deposit_memory(port_partition_id, status);
 	} while (!ret);
 
 	return ret;
@@ -776,8 +772,7 @@ hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
 			ret = hv_result_to_errno(status);
 			break;
 		}
-		ret = hv_call_deposit_pages(NUMA_NO_NODE,
-					    connection_partition_id, 1);
+		ret = hv_deposit_memory(connection_partition_id, status);
 	} while (!ret);
 
 	return ret;
@@ -848,8 +843,7 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
 			break;
 		}
 
-		ret = hv_call_deposit_pages(NUMA_NO_NODE,
-					    hv_current_partition_id, 1);
+		ret = hv_deposit_memory(hv_current_partition_id, status);
 	} while (!ret);
 
 	return ret;
@@ -885,8 +879,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
 			return ret;
 		}
 
-		ret = hv_call_deposit_pages(NUMA_NO_NODE,
-					    hv_current_partition_id, 1);
+		ret = hv_deposit_memory(hv_current_partition_id, status);
 		if (ret)
 			return ret;
 	} while (!ret);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index ee30bfa6bb2e..dce255c94f9e 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -264,8 +264,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 		if (!hv_result_needs_memory(status))
 			ret = hv_result_to_errno(status);
 		else
-			ret = hv_call_deposit_pages(NUMA_NO_NODE,
-						    pt_id, 1);
+			ret = hv_deposit_memory(pt_id, status);
 	} while (!ret);
 
 	args.status = hv_result(status);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 452426d5b2ab..d37b68238c97 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -344,6 +344,7 @@ static inline bool hv_parent_partition(void)
 }
 
 bool hv_result_needs_memory(u64 status);
+int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
@@ -353,6 +354,10 @@ static inline bool hv_root_partition(void) { return false; }
 static inline bool hv_l1vh_partition(void) { return false; }
 static inline bool hv_parent_partition(void) { return false; }
 static inline bool hv_result_needs_memory(u64 status) { return false; }
+static inline int hv_deposit_memory_node(int node, u64 partition_id, u64 status)
+{
+	return -EOPNOTSUPP;
+}
 static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 {
 	return -EOPNOTSUPP;
@@ -367,6 +372,11 @@ static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u3
 }
 #endif /* CONFIG_MSHV_ROOT */
 
+static inline int hv_deposit_memory(u64 partition_id, u64 status)
+{
+	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status);
+}
+
 #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
 u8 __init get_vtl(void);
 #else



