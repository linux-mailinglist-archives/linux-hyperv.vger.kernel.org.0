Return-Path: <linux-hyperv+bounces-11172-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DyaEgsdEWrIhQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11172-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 05:20:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA905BCF38
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 05:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 809223054319
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 03:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1572E33D6FA;
	Sat, 23 May 2026 03:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nEUmoQIj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611153314C5;
	Sat, 23 May 2026 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779506138; cv=none; b=DqIGJjHLS1+T3xT4D3NEW4jUN6M6EFioirtEHdtvcH/DryJTJYrzbrxa/wRjgRtIDz6mdmW59/y6kQZKHdsih8xwaMLuwuMjjjA9ddEQ7u1Dn65yrr1sLja7As1KmhQeVXNyiiyk9JcSEJvgTVSIh8EZqi9S/KsHa6QuDjX48no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779506138; c=relaxed/simple;
	bh=ulQEQQ0A/MpfmAshxlTVNUaOUKKA6FA7LV/2rVnQqF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXNkA06M7lxzDc63F8e3vujZsWuoTLvyzqX1NF36FTaO4dtHrArOGRt00c6y/FINxo0W/gRYMErVCaGb4nNOEoY3N99mAN82b/d0/+MEyU1lKaISf/jx7no2XpkVgulGfHcAWWZYoO/hWcdNjsy9h9pJpEAwkbRLnonlbqx/mk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nEUmoQIj; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MHW0VO2622946;
	Sat, 23 May 2026 03:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7wzS14WVDJQWU2EwGyZLqtbho9V99BJWNFtRuDUf3/E=; b=
	nEUmoQIjH9nRrB8mznYLzx/nFAnifdrZWEasqo9Ufrh7RiapIxQycu/L3vyc1VeV
	V3HeIPoC4wWx44VJnc4B7yKAoUk2bG6+doV+DBSPROPocBqrJI9yQv5GBTNs2bBA
	HVu2xueN7775NKvgRmyVl7m6wwrKEZvmYrk8b/3Exl0TfCuaZ+zBsNS6DYxJKWXE
	KgPVT/WZaVi9G5v8fXlcAQwkEA0iIqijTuMiHnhiy7vfg0tTOh7fdLiV+Ey1xTln
	Wcbwd1L6qS5ZOtTXbRYkloGtfLdTX2WKozKDfN93oGaPo9p+MzPSSppqoBVpFLbd
	GPCOHYPOX07mkGVf3K61iQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h1t4e5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 03:15:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64N3F5ak032306;
	Sat, 23 May 2026 03:15:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4eb2p6hskn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 03:15:27 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64N3F9eO032824;
	Sat, 23 May 2026 03:15:26 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4eb2p6hs6k-16;
	Sat, 23 May 2026 03:15:26 +0000 (GMT)
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, longli@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mhklinux@outlook.com
Subject: Re: [PATCH v2] scsi: storvsc: Replace symbolic permissions with octal
Date: Fri, 22 May 2026 23:14:30 -0400
Message-ID: <177913641771.1181900.14473313849587305075.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506004948.2172-1-shofiqtest@gmail.com>
References: <20260506004948.2172-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=576 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605230029
X-Proofpoint-GUID: zDgM3pwFtfh8LoySytLKY4cYOfAvJte6
X-Authority-Analysis: v=2.4 cv=d9jFDxjE c=1 sm=1 tr=0 ts=6a111bd0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=UY0ZMbisSNrLhDL-TgMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zDgM3pwFtfh8LoySytLKY4cYOfAvJte6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDAyOSBTYWx0ZWRfX+vBmpXoouOOL
 QXQg04smDO3kpZMObMlAumwJAOZkz7FmVobzTbR6uI68FDWwKM9It1E/ayPlb7rg45Xo6bIKkTv
 LVXGmE9mxqaF+4pq9nzaSooxyCQF70T4h2bxWh+y25fzfGTpmusCtY8q5mBG6nQw3xux0r/Q3Xu
 kXOdM/yPDbeRVprUmk93qhNejDAc3DXigJCzLRoRTh5uWNcAE1A+SEonaMNnB4dZp+3aqIGvnIs
 dqa0o/tzJ76OIqCD37hh/5mO60nyn1SER1kAwYDtWOG57M4FT0OfsVrqfLjJ6NONhRvns1VO0Gm
 zxSzKeHxuCNtb4kyLnxX2vIIoB98z9BQLfC1uJNA97BudULmfoYLgTPfdqEYDmb3fqjNgU5xcuj
 seuYQHmFJKeC256Z5M/nMXITs6VI7n64TdtpG2Mz1Ewx35WwgZCBVn039+futdAu2lLsaEEiOH5
 g+TsV9XPrheOE5GVLvw==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,microsoft.com,kernel.org,outlook.com];
	TAGGED_FROM(0.00)[bounces-11172-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:mid,oracle.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: ABA905BCF38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 06 May 2026 03:49:48 +0300, Md Shofiqul Islam wrote:

> Symbolic permissions like S_IRUGO and S_IWUSR are not preferred by
> checkpatch. Replace with their octal equivalents:
> 
>   - S_IRUGO|S_IWUSR -> 0644
>   - S_IRUGO         -> 0444
> 
> 
> [...]

Applied to 7.2/scsi-queue, thanks!

[1/1] scsi: storvsc: Replace symbolic permissions with octal
      https://git.kernel.org/mkp/scsi/c/73322071418e

-- 
Martin K. Petersen

