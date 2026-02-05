Return-Path: <linux-hyperv+bounces-8743-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO20MpDkhGlf6QMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8743-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:42:24 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB5BF6850
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D6EA3003BD3
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 18:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32093033F2;
	Thu,  5 Feb 2026 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O0M7+2X0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A2D3033F5;
	Thu,  5 Feb 2026 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770316936; cv=none; b=UgeaO5rfb3xF3mwH35cwlY6gJdHHPEUD3QFOM3HAxMX9yfPoDrzcMu4kJYofQwOhPCpPWTesT3wYt6Xf8lGp7xBNzlcAgyYzRFjTvpcePTLn9UOPIVpUAN2RRs8X/X1FlySAUv/bHrAMTUUD++fx60o5oTtFw54avG6bjrNmmhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770316936; c=relaxed/simple;
	bh=NjAEETLoYHJIoVUlQo84fgZ3JJm/donD4C2EOGIay28=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmjmmSqbpV88VjnWQbR69yRHl5WWczcjggZfZ5W+FO2ABU+93eI233jKd2Wv0yvvl0df5jGGkNuh0j11fVmu3EpiqhtNqh1wQC0Dy1hfZeh485VzhLrG6Xt5vsed/lmG2ckVT1aZK2RJUlDQtlYTRfRwQe3p7J0nmlUch0tks9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=O0M7+2X0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4F7D620B7168;
	Thu,  5 Feb 2026 10:42:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F7D620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770316936;
	bh=fokEJQndFDd6r1h9x20kemrrZlWIyq13c1edrhB85hA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=O0M7+2X0wn24qk6/1ysWokLL9fmFtco/hiSLqFfUvxXz6q+JVjc1pqHKSUPtxbvK8
	 6vVp2dkwblBmDJa0nwSSLuzYbJgXZ1ECLNItEj52Jsd5JuN35dE8+VGEV/ALBeLJyB
	 dXV3nlWOR9HpTzMvL74Y4Soe/IBIO0FiH6UCOZJQ=
Subject: [PATCH v3 2/4] mshv: Introduce hv_deposit_memory helper functions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Feb 2026 18:42:15 +0000
Message-ID: 
 <177031693589.186911.13080983340478852205.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8743-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFB5BF6850
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
 drivers/hv/hv_proc.c           |   21 +++++++++++++++++++--
 drivers/hv/mshv_root_hv_call.c |   25 +++++++++----------------
 drivers/hv/mshv_root_main.c    |    3 +--
 include/asm-generic/mshyperv.h |   10 ++++++++++
 4 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index e53204b9e05d..53622e5886b8 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -110,6 +110,22 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 }
 EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
 
+int hv_deposit_memory_node(int node, u64 partition_id,
+			   u64 hv_status)
+{
+	u32 num_pages = 1;
+
+	switch (hv_result(hv_status)) {
+	case HV_STATUS_INSUFFICIENT_MEMORY:
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
@@ -155,7 +171,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 			}
 			break;
 		}
-		ret = hv_call_deposit_pages(node, hv_current_partition_id, 1);
+		ret = hv_deposit_memory_node(node, hv_current_partition_id,
+					     status);
 	} while (!ret);
 
 	return ret;
@@ -197,7 +214,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 			}
 			break;
 		}
-		ret = hv_call_deposit_pages(node, partition_id, 1);
+		ret = hv_deposit_memory_node(node, partition_id, status);
 
 	} while (!ret);
 
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 1c4a2dbf49c0..7f91096f95a8 100644
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
@@ -855,8 +850,7 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
 			break;
 		}
 
-		ret = hv_call_deposit_pages(NUMA_NO_NODE,
-					    hv_current_partition_id, 1);
+		ret = hv_deposit_memory(hv_current_partition_id, status);
 	} while (!ret);
 
 	return ret;
@@ -929,8 +923,7 @@ hv_call_map_stats_page(enum hv_stats_object_type type,
 			return hv_result_to_errno(status);
 		}
 
-		ret = hv_call_deposit_pages(NUMA_NO_NODE,
-					    hv_current_partition_id, 1);
+		ret = hv_deposit_memory(hv_current_partition_id, status);
 		if (ret)
 			return ret;
 	} while (!ret);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index f5525651a565..cf58d9954638 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -254,8 +254,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
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



