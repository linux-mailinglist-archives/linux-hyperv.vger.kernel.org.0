Return-Path: <linux-hyperv+bounces-4845-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB81A82A28
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 17:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF537AB6AD
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FD8266B5D;
	Wed,  9 Apr 2025 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gprqXmBC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67FF1DFFD;
	Wed,  9 Apr 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212205; cv=none; b=sA4MV4aM0AtcTWveWe2RrXcxgMhBBE28veq5S+AWIjWN4CA5yuiI10fq0kV2oi0dDCsZ4N1jbaEc35M++l/25DK5LWd9+bGMaZXOV2jAE+wgot7T2754KRy5iYNBc/BZ/Zab8yQ+Qhl8ApY/zWvzMQDqn1yExhK4DdVF3B8mIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212205; c=relaxed/simple;
	bh=9N1NF3CqX6CI171CJlg3zeVkou7wQc8y9+DoTh/HPcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhIwsF5ZLY2XY2BjP49MjuPPa3x23qOk1K3aI8J1FB5ca2wBUu+QewwIwS5mcTF7mFXhF/PiUgENu+3FBbFqRuCas5DACynbAZBjltzKqwkv+4QAZ2O/0/0374rAa2PAUBllERLDycZscmRY4n99rqrjPN2zknxdAfuMB07/Gv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gprqXmBC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539A0RWg008866;
	Wed, 9 Apr 2025 15:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UD5ziO
	CSUS/zVJxI5iQCqBhTxQrQYo4uOaPECKb7CFs=; b=gprqXmBCTFFahLum4nyHXU
	NbQDOcXitZK3KUdmcaGywysROm5F9mO0tB3nswtWq7a1Y3Obd8rEFCMQ1py2R0d9
	LPtfMXuQsIDdSt3D7DrTEs4ca67hKL6vKvh53oBaeIz+gBm+oGhg2MDrEGJIlcBU
	pBJHXi+fQWYKr9RrdBMSxS4ShGnijpu4c7f1PLZ1nvxEvaoTBMgG5LKMmxfaDRtG
	IkwbQFavNEeToerrI0AFFEKUUJQs1XHAzpnJhsf1gAmfNkc40rZzZWmi9u2DKG12
	DnPBX/9cz2lYN4NBVUMcfveIyGqaunVA3x/e6JvxcAJEKfvR0pQUSZOQLhA2ctmw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wayr4dww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 15:22:21 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 539FMK4a003291;
	Wed, 9 Apr 2025 15:22:20 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wayr4dws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 15:22:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539E5swi017447;
	Wed, 9 Apr 2025 15:22:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kr4du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 15:22:19 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539FMIVw25428476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 15:22:18 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25C8058053;
	Wed,  9 Apr 2025 15:22:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7D0E58059;
	Wed,  9 Apr 2025 15:22:09 +0000 (GMT)
Received: from [9.61.248.89] (unknown [9.61.248.89])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 15:22:09 +0000 (GMT)
Message-ID: <105f1b15-9536-4847-a3c5-8ca0993cfa35@linux.ibm.com>
Date: Wed, 9 Apr 2025 20:52:08 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7b025f3f85ed causes NULL pointer dereference
To: Thomas Gleixner <tglx@linutronix.de>, Bert Karwatzki <spasswolf@web.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, Jonathan.Cameron@huawei.com,
        allenbh@gmail.com, d-gole@ti.com, dave.jiang@intel.com,
        haiyangz@microsoft.com, jdmason@kudzu.us, kristo@kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, logang@deltatee.com,
        manivannan.sadhasivam@linaro.org, martin.petersen@oracle.com,
        maz@kernel.org, mhklinux@outlook.com, nm@ti.com, ntb@lists.linux.dev,
        peterz@infradead.org, ssantosh@kernel.org, wei.huang2@amd.com,
        wei.liu@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, venkat88@linux.ibm.com
References: <20250408120446.3128-1-spasswolf@web.de> <87iknevgfb.ffs@tglx>
 <87friivfht.ffs@tglx> <f303b266172050f2ec0dc5168b23e0cea9138b01.camel@web.de>
 <87a58qv0tn.ffs@tglx>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <87a58qv0tn.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K0j9-S0-7MhHZv4iZrAgfjbRog9_Afjv
X-Proofpoint-GUID: s6FUoYEm87oi5YTiionJnOj6VvrwtrP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090094


On 09/04/25 2:16 am, Thomas Gleixner wrote:
> On Tue, Apr 08 2025 at 18:20, Bert Karwatzki wrote:
>> Am Dienstag, dem 08.04.2025 um 17:29 +0200 schrieb Thomas Gleixner:
>>>> Can you please decode the lines please via:
>>>>
>>>>      scripts/faddr2line vmlinux msi_domain_first_desc+0x4/0x30
>>>>      scripts/faddr2line vmlinux msix_setup_interrupts+0x23b/0x280
>> I had to recompile with CONFIG_DEBUG_INFO=Y, and reran the test, the calltrace
>> is identical.
>>
>> $ scripts/faddr2line vmlinux msi_domain_first_desc+0x4/0x30
>> msi_domain_first_desc+0x4/0x30:
>> msi_domain_first_desc at kernel/irq/msi.c:400
>>
>> So it seems msi_domain_first_desc() is called with dev = NULL.


This issue is seen on IBM Power9 server also. Bisection is pointing to 
7b025f3f85ed4283d5a414371bb2ffd38d19033f as first bad commit.

I applied this patch on top of 20250409 and it fixes the issue.


> Yup
>
>> $ scripts/faddr2line vmlinux msix_setup_interrupts+0x23b/0x280
>> msix_setup_interrupts+0x23b/0x280:
>> msix_update_entries at drivers/pci/msi/msi.c:647 (discriminator 1)
> Aaarg. The patch below should fix that.
>
> Thanks,
>
>          tglx
> ---
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 4027abcafe7a..77cc27e45b66 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -680,8 +680,8 @@ static int __msix_setup_interrupts(struct pci_dev *__dev, struct msix_entry *ent
>   	if (ret)
>   		return ret;
>   
> -	retain_ptr(dev);
>   	msix_update_entries(dev, entries);
> +	retain_ptr(dev);
>   	return 0;
>   }
>   

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


