Return-Path: <linux-hyperv+bounces-9022-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A2NKZ9RoWkBsQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9022-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 09:11:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA961B447A
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 09:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0AFA3017BF3
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 08:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351413563E1;
	Fri, 27 Feb 2026 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEsilo3C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7992C361DB0
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179868; cv=none; b=bGdFXKE3/lIU1tjGCrjEJzktBx5wJESUZBwOc7AjW6hmxxlpXwmXMWOmPSdMAOx4wGbtoyjyGxx7RRHpMmmoC50muPCOsXlkOWvCLCDkq2hh2d1w6tcvCoDaY5YuP7rxGzfsfKoKN4JAOKwzgwsxFfaAn7JwHNgY74a+k1hsSf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179868; c=relaxed/simple;
	bh=h545sH5JP7cq0FYBaba5LSLeqkoazSa5z5sgcGMTMm0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TY1/jMRiOyfHhnPXMSe3QVI4cAg6SAaIeFsEfOlx2mYw5+ZR2oQyYFHNgL2otLFrnfFVw25w1Pf8Snj7kg3nV25eVCsimk2LeRH/0grULdw4orzMJhj19AGmQLR8soJBDtEvQT5IrUxeDNTQaz9Q4nr+CgGshXvMecfZ1DeOz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MEsilo3C; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so14182075e9.3
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 00:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772179865; x=1772784665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZmaHsQoW2ym4yvD8dDk2Aay7lPHS5+f4YhmsNPYSH8=;
        b=MEsilo3CSUMEUQatYv+uTLLBXYZqGSyiu5LThjfFWVbDf9UU/kDkfhEteluLmhBYa2
         w6DtOsrIiDzPhR28X7Pg92eE+QhF0Evy4GnyuuxWKVU9XtO6JrxVmgI5iD/FxxNsmQIS
         XAT1HABuItzZSrvvLkxxPxFqufCZMp+Z1SFdqGaxVH5jWlmAwdRggRA/52lX3e60QzW5
         41DP8w8Tm6qwcUbbi9QJ/NtIeVoROiiAJvu8n8/jMzbw6dkIKJHSigTVDggbNHXziOul
         0v0TP/7gs0bhz7iViJ9y8NxrIQ3LqH6T39lngCWlnuNxZJGkzK22Enqseu33Lo0tGHKJ
         H0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772179865; x=1772784665;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZmaHsQoW2ym4yvD8dDk2Aay7lPHS5+f4YhmsNPYSH8=;
        b=XnuWgfoCGjJZYR9qr15KxXdoNZ7NVdvyR04xMZCO6jQbA42tqyy1fWZPIfHYcsj2Ab
         DGHKfqHlmaHhkMEc8ySLSJJ6OSX8AJ3VNDmMur9/ZV4GUWxXR+OVkgarv3CfTUpwAq6X
         NHw3cempfjHrPcGF7lJOKbw4nAu91MLDvu4zPA4y13ooxV4/zqzsxaGOQvGbMEjxBHSu
         YK5AAAl1ZmTk59GyHFG7hECVJqkKfQWT0bsq0XpbRlUeVOrk2i6w9+HzO/SJLBAl2Is0
         QramJeROgbs8z3SczFtHF37F6e5jUO3QYhaAojTJoS97I15T2n/GHyPJT8Bzp/3pOihQ
         GeOA==
X-Forwarded-Encrypted: i=1; AJvYcCXIb3B1doqsvecYPDm2pidVnglIcX7AbCoKbi5rmtcXbmnkxvRLv1Hn7j8y3SWUW58cyq/B3VLyNgJieXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxndHGV+bTBKzaMIjp62t8PhD74pG29K++rQSI9BlmsGQnsl/E0
	MHLw+vTSKZlhA274o60oNvVVTHGynbc5ObyhzbrwM46QXo65U69wEYICbXEgLC70z1c=
X-Gm-Gg: ATEYQzxU/z+q/IwLns68IsQxRfHu72PspNWdaIGIIkJNSKgcfGSacZfMCG3PqMNrU0o
	itNZEURtYRgIewq2lrW8ecZzirDJpkmS90DpWCzc34ta5BlnAMo0ZMsYc/3EdzNXkqJ8nzYL/Hz
	kxvGyc2XI3sXLKa2ho08ZCemgRb+vrYADJccMdyYLuJcQvIrLTY51axGInipEBpCqCSlnus1njH
	em39RDQ5egKQSgGOWaGjEud2OWXVyIsc8SKjaUqxTwrUbtDZG3fFen4nu8ZbZFINGyuKUIBGhzi
	5V8GlAIzJf6khOI/cbS98Gr5wq/Xjg07pYrLtNsFHyFIB+rW1YM5jFxHIrAACxhbYLVlXzwEnHY
	v0VPBWDAc07nmHqswQUuXlcaf5uwgmfXq9e89MHldRp+i+/9X9/tnXi79WBlK+GWxhq88utRvKQ
	qgbPzo4tFxFvCmMbrXsEt6xbtqs1nksNCTP2WnFbE=
X-Received: by 2002:a05:600c:1f91:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-483c9ba3683mr24302515e9.3.1772179864758;
        Fri, 27 Feb 2026 00:11:04 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3471asm98930155e9.3.2026.02.27.00.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 00:11:04 -0800 (PST)
Date: Fri, 27 Feb 2026 11:11:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Introduce tracing support
Message-ID: <202602271528.jLhA59mn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177213348504.92223.5330421592610811972.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9022-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1BA961B447A
X-Rspamd-Action: no action

Hi Stanislav,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Kinsburskii/mshv-Introduce-tracing-support/20260227-031942
base:   linus/master
patch link:    https://lore.kernel.org/r/177213348504.92223.5330421592610811972.stgit%40skinsburskii-cloud-desktop.internal.cloudapp.net
patch subject: [PATCH] mshv: Introduce tracing support
config: x86_64-randconfig-161-20260227 (https://download.01.org/0day-ci/archive/20260227/202602271528.jLhA59mn-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202602271528.jLhA59mn-lkp@intel.com/

New smatch warnings:
drivers/hv/mshv_root_main.c:1177 mshv_partition_ioctl_create_vp() error: we previously assumed 'vp' could be null (see line 1110)
drivers/hv/mshv_root_main.c:1177 mshv_partition_ioctl_create_vp() error: dereferencing freed memory 'vp' (line 1157)

vim +/vp +1177 drivers/hv/mshv_root_main.c

621191d709b148 Nuno Das Neves        2025-03-14  1057  static long
621191d709b148 Nuno Das Neves        2025-03-14  1058  mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
621191d709b148 Nuno Das Neves        2025-03-14  1059  			       void __user *arg)
621191d709b148 Nuno Das Neves        2025-03-14  1060  {
621191d709b148 Nuno Das Neves        2025-03-14  1061  	struct mshv_create_vp args;
621191d709b148 Nuno Das Neves        2025-03-14  1062  	struct mshv_vp *vp;
19c515c27cee3b Jinank Jain           2025-10-10  1063  	struct page *intercept_msg_page, *register_page, *ghcb_page;
2de4516aa8f726 Stanislav Kinsburskii 2026-01-28  1064  	struct hv_stats_page *stats_pages[2];
621191d709b148 Nuno Das Neves        2025-03-14  1065  	long ret;
621191d709b148 Nuno Das Neves        2025-03-14  1066  
621191d709b148 Nuno Das Neves        2025-03-14  1067  	if (copy_from_user(&args, arg, sizeof(args)))
621191d709b148 Nuno Das Neves        2025-03-14  1068  		return -EFAULT;
621191d709b148 Nuno Das Neves        2025-03-14  1069  
621191d709b148 Nuno Das Neves        2025-03-14  1070  	if (args.vp_index >= MSHV_MAX_VPS)
621191d709b148 Nuno Das Neves        2025-03-14  1071  		return -EINVAL;
621191d709b148 Nuno Das Neves        2025-03-14  1072  
621191d709b148 Nuno Das Neves        2025-03-14  1073  	if (partition->pt_vp_array[args.vp_index])
621191d709b148 Nuno Das Neves        2025-03-14  1074  		return -EEXIST;
621191d709b148 Nuno Das Neves        2025-03-14  1075  
621191d709b148 Nuno Das Neves        2025-03-14  1076  	ret = hv_call_create_vp(NUMA_NO_NODE, partition->pt_id, args.vp_index,
621191d709b148 Nuno Das Neves        2025-03-14  1077  				0 /* Only valid for root partition VPs */);
621191d709b148 Nuno Das Neves        2025-03-14  1078  	if (ret)
621191d709b148 Nuno Das Neves        2025-03-14  1079  		return ret;
621191d709b148 Nuno Das Neves        2025-03-14  1080  
19c515c27cee3b Jinank Jain           2025-10-10  1081  	ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
621191d709b148 Nuno Das Neves        2025-03-14  1082  				   HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
19c515c27cee3b Jinank Jain           2025-10-10  1083  				   input_vtl_zero, &intercept_msg_page);
621191d709b148 Nuno Das Neves        2025-03-14  1084  	if (ret)
621191d709b148 Nuno Das Neves        2025-03-14  1085  		goto destroy_vp;
621191d709b148 Nuno Das Neves        2025-03-14  1086  
621191d709b148 Nuno Das Neves        2025-03-14  1087  	if (!mshv_partition_encrypted(partition)) {
19c515c27cee3b Jinank Jain           2025-10-10  1088  		ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
621191d709b148 Nuno Das Neves        2025-03-14  1089  					   HV_VP_STATE_PAGE_REGISTERS,
19c515c27cee3b Jinank Jain           2025-10-10  1090  					   input_vtl_zero, &register_page);
621191d709b148 Nuno Das Neves        2025-03-14  1091  		if (ret)
621191d709b148 Nuno Das Neves        2025-03-14  1092  			goto unmap_intercept_message_page;
621191d709b148 Nuno Das Neves        2025-03-14  1093  	}
621191d709b148 Nuno Das Neves        2025-03-14  1094  
621191d709b148 Nuno Das Neves        2025-03-14  1095  	if (mshv_partition_encrypted(partition) &&
621191d709b148 Nuno Das Neves        2025-03-14  1096  	    is_ghcb_mapping_available()) {
19c515c27cee3b Jinank Jain           2025-10-10  1097  		ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
621191d709b148 Nuno Das Neves        2025-03-14  1098  					   HV_VP_STATE_PAGE_GHCB,
19c515c27cee3b Jinank Jain           2025-10-10  1099  					   input_vtl_normal, &ghcb_page);
621191d709b148 Nuno Das Neves        2025-03-14  1100  		if (ret)
621191d709b148 Nuno Das Neves        2025-03-14  1101  			goto unmap_register_page;
621191d709b148 Nuno Das Neves        2025-03-14  1102  	}
621191d709b148 Nuno Das Neves        2025-03-14  1103  
621191d709b148 Nuno Das Neves        2025-03-14  1104  	ret = mshv_vp_stats_map(partition->pt_id, args.vp_index,
621191d709b148 Nuno Das Neves        2025-03-14  1105  				stats_pages);
621191d709b148 Nuno Das Neves        2025-03-14  1106  	if (ret)
621191d709b148 Nuno Das Neves        2025-03-14  1107  		goto unmap_ghcb_page;
621191d709b148 Nuno Das Neves        2025-03-14  1108  
bf4afc53b77aea Linus Torvalds        2026-02-21  1109  	vp = kzalloc_obj(*vp);
621191d709b148 Nuno Das Neves        2025-03-14 @1110  	if (!vp)
621191d709b148 Nuno Das Neves        2025-03-14  1111  		goto unmap_stats_pages;

vp is NULL

621191d709b148 Nuno Das Neves        2025-03-14  1112  
621191d709b148 Nuno Das Neves        2025-03-14  1113  	vp->vp_partition = mshv_partition_get(partition);
621191d709b148 Nuno Das Neves        2025-03-14  1114  	if (!vp->vp_partition) {
621191d709b148 Nuno Das Neves        2025-03-14  1115  		ret = -EBADF;
621191d709b148 Nuno Das Neves        2025-03-14  1116  		goto free_vp;
621191d709b148 Nuno Das Neves        2025-03-14  1117  	}
621191d709b148 Nuno Das Neves        2025-03-14  1118  
621191d709b148 Nuno Das Neves        2025-03-14  1119  	mutex_init(&vp->vp_mutex);
621191d709b148 Nuno Das Neves        2025-03-14  1120  	init_waitqueue_head(&vp->run.vp_suspend_queue);
621191d709b148 Nuno Das Neves        2025-03-14  1121  	atomic64_set(&vp->run.vp_signaled_count, 0);
621191d709b148 Nuno Das Neves        2025-03-14  1122  
621191d709b148 Nuno Das Neves        2025-03-14  1123  	vp->vp_index = args.vp_index;
19c515c27cee3b Jinank Jain           2025-10-10  1124  	vp->vp_intercept_msg_page = page_to_virt(intercept_msg_page);
621191d709b148 Nuno Das Neves        2025-03-14  1125  	if (!mshv_partition_encrypted(partition))
621191d709b148 Nuno Das Neves        2025-03-14  1126  		vp->vp_register_page = page_to_virt(register_page);
621191d709b148 Nuno Das Neves        2025-03-14  1127  
621191d709b148 Nuno Das Neves        2025-03-14  1128  	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
621191d709b148 Nuno Das Neves        2025-03-14  1129  		vp->vp_ghcb_page = page_to_virt(ghcb_page);
621191d709b148 Nuno Das Neves        2025-03-14  1130  
621191d709b148 Nuno Das Neves        2025-03-14  1131  	memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
621191d709b148 Nuno Das Neves        2025-03-14  1132  
ff225ba9ad71c4 Nuno Das Neves        2026-01-28  1133  	ret = mshv_debugfs_vp_create(vp);
ff225ba9ad71c4 Nuno Das Neves        2026-01-28  1134  	if (ret)
ff225ba9ad71c4 Nuno Das Neves        2026-01-28  1135  		goto put_partition;
ff225ba9ad71c4 Nuno Das Neves        2026-01-28  1136  
621191d709b148 Nuno Das Neves        2025-03-14  1137  	/*
621191d709b148 Nuno Das Neves        2025-03-14  1138  	 * Keep anon_inode_getfd last: it installs fd in the file struct and
621191d709b148 Nuno Das Neves        2025-03-14  1139  	 * thus makes the state accessible in user space.
621191d709b148 Nuno Das Neves        2025-03-14  1140  	 */
621191d709b148 Nuno Das Neves        2025-03-14  1141  	ret = anon_inode_getfd("mshv_vp", &mshv_vp_fops, vp,
621191d709b148 Nuno Das Neves        2025-03-14  1142  			       O_RDWR | O_CLOEXEC);
621191d709b148 Nuno Das Neves        2025-03-14  1143  	if (ret < 0)
ff225ba9ad71c4 Nuno Das Neves        2026-01-28  1144  		goto remove_debugfs_vp;
621191d709b148 Nuno Das Neves        2025-03-14  1145  
621191d709b148 Nuno Das Neves        2025-03-14  1146  	/* already exclusive with the partition mutex for all ioctls */
621191d709b148 Nuno Das Neves        2025-03-14  1147  	partition->pt_vp_count++;
621191d709b148 Nuno Das Neves        2025-03-14  1148  	partition->pt_vp_array[args.vp_index] = vp;
621191d709b148 Nuno Das Neves        2025-03-14  1149  
33c08ba966cf23 Stanislav Kinsburskii 2026-02-26  1150  	goto out;
621191d709b148 Nuno Das Neves        2025-03-14  1151  
ff225ba9ad71c4 Nuno Das Neves        2026-01-28  1152  remove_debugfs_vp:
ff225ba9ad71c4 Nuno Das Neves        2026-01-28  1153  	mshv_debugfs_vp_remove(vp);
621191d709b148 Nuno Das Neves        2025-03-14  1154  put_partition:
621191d709b148 Nuno Das Neves        2025-03-14  1155  	mshv_partition_put(partition);
621191d709b148 Nuno Das Neves        2025-03-14  1156  free_vp:
621191d709b148 Nuno Das Neves        2025-03-14 @1157  	kfree(vp);
                                                              ^^
freed.

621191d709b148 Nuno Das Neves        2025-03-14  1158  unmap_stats_pages:
d62313bdf5961b Jinank Jain           2025-10-10  1159  	mshv_vp_stats_unmap(partition->pt_id, args.vp_index, stats_pages);
621191d709b148 Nuno Das Neves        2025-03-14  1160  unmap_ghcb_page:
19c515c27cee3b Jinank Jain           2025-10-10  1161  	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
19c515c27cee3b Jinank Jain           2025-10-10  1162  		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
19c515c27cee3b Jinank Jain           2025-10-10  1163  				       HV_VP_STATE_PAGE_GHCB, ghcb_page,
621191d709b148 Nuno Das Neves        2025-03-14  1164  				       input_vtl_normal);
621191d709b148 Nuno Das Neves        2025-03-14  1165  unmap_register_page:
19c515c27cee3b Jinank Jain           2025-10-10  1166  	if (!mshv_partition_encrypted(partition))
19c515c27cee3b Jinank Jain           2025-10-10  1167  		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
621191d709b148 Nuno Das Neves        2025-03-14  1168  				       HV_VP_STATE_PAGE_REGISTERS,
19c515c27cee3b Jinank Jain           2025-10-10  1169  				       register_page, input_vtl_zero);
621191d709b148 Nuno Das Neves        2025-03-14  1170  unmap_intercept_message_page:
19c515c27cee3b Jinank Jain           2025-10-10  1171  	hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
621191d709b148 Nuno Das Neves        2025-03-14  1172  			       HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
19c515c27cee3b Jinank Jain           2025-10-10  1173  			       intercept_msg_page, input_vtl_zero);
621191d709b148 Nuno Das Neves        2025-03-14  1174  destroy_vp:
621191d709b148 Nuno Das Neves        2025-03-14  1175  	hv_call_delete_vp(partition->pt_id, args.vp_index);
33c08ba966cf23 Stanislav Kinsburskii 2026-02-26  1176  out:
33c08ba966cf23 Stanislav Kinsburskii 2026-02-26 @1177  	trace_mshv_create_vp(partition->pt_id, vp->vp_index, ret);
                                                                                               ^^^^^^^^^^^^
vp dereferenced.

621191d709b148 Nuno Das Neves        2025-03-14  1178  	return ret;
621191d709b148 Nuno Das Neves        2025-03-14  1179  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


