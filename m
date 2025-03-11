Return-Path: <linux-hyperv+bounces-4400-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0CEA5CD05
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 19:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9778117BE79
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 18:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0B8263885;
	Tue, 11 Mar 2025 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f7mlYYFt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C70263881
	for <linux-hyperv@vger.kernel.org>; Tue, 11 Mar 2025 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716077; cv=none; b=RzyrKOZ+6fTHLi59zAocqbngAKt3lKgtwFGc2cQFoTX1nU0Rr0v06d4e+dU3yU9ADw5RVTwaFL7bgrN1GF4QGMtepgj3liwMnVVH5tYrmITtMQ9x44C/hi/SLWUA8ayplsD5so5cFCccmV4eHRo26ie+M7wZlowKlnQSD0QNK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716077; c=relaxed/simple;
	bh=YGUtbaoC0vpuFL55AG2VRarJ9dc5j39vjlLJQCOeDKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHQ1Dax/+ybHe6rx/Thu7XZhA5UfgV6U7LTtu8ho/gJQ/CXVojrfYHTB/g/NMkG1EBZ339qGb4fj/1WimFK59SLRYp7IuJ8czqz7Y7APfOPP3zFitf+/ytdwuq/GGTpd4/SOefv1xnNSaexTGjZfWD+Cc4icjs5uN5XdBCJFm9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f7mlYYFt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BG8gfw029174
	for <linux-hyperv@vger.kernel.org>; Tue, 11 Mar 2025 18:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YGUtbaoC0vpuFL55AG2VRarJ9dc5j39vjlLJQCOeDKA=; b=f7mlYYFt7jkvBncL
	ycrW6gqllkYuuuP3eTk0nPUOru3/oztfu4M12Rsz0adLFr5RPvGIcBuN8ygDnBmu
	/pZof8XL1WNBqVfjFWFebjQsJwKSYA/mhNQBJ53Fno+SvN9PH5R7kxj7/1naiuDM
	oKRz8gEx/HBvBDWeoO00EaDM8YgLJm2OmidoWAvqsCRy5ZMbzzwnjY1jsrIVwGPp
	o/9GxJe7/wVT3DfWhZNrMExav2YbW4Ft2kB/xLtC44/ARLdQL0wqQ692IQ8iwMnk
	GI3X+9EPx+rPEusBSj6czHHjjZmdw+FFSiQwBbo8X6mI+9vXEmCFPZjukOmu5YoZ
	DNS4pA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ah1y9vas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 11 Mar 2025 18:01:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2240a7aceeaso102919235ad.0
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Mar 2025 11:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741716074; x=1742320874;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGUtbaoC0vpuFL55AG2VRarJ9dc5j39vjlLJQCOeDKA=;
        b=hpB7DurKBf6lTNNoB7QjP2HewAXU7mmgekUNLKcKPQZylesOPMPZ57mYa7nKJBrjAS
         mTWfqesf9fbeuxBr/BDkms4Efs5ZcIJoVVwIfcizhI6QAL4Z5xTAiSqwVkSsXrkDG3er
         hZOM9raupT6/BxcnvZJPSlam5GcSlceoDaD2E82mTGfssdcdo2gIl3O8y8rRb2NjQpnC
         zyhp73lXq9bvHcRgid2djrm/D9ZWU+USAsKupPVE6B2wigqV7UpkwWYEkKIWhCWAqPVq
         m400DWtj5p8BXvXOGKzxXeJ1ubQYVjFzqd7+nSilHydVHbfTx7O74aDSiBItsle524p4
         Kbow==
X-Forwarded-Encrypted: i=1; AJvYcCXEG3r5vQFkJut/LoMH/QaXGIIeymROSzpaSpuM2bVKzvUs292prXNwGzHuFvqIvnVmmLH+qDx+jHUD6pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhxKwkFFdBTmbBnpT7QapBcIHaEsYmGXxua6SfYjdyj2qKGguS
	uOjE4MzWNZLiDbXkjiRzhXttjSBReEYB+N9V63nFBrvzUpJj55q0m/jwLQ0lvnDiBkQSBXvDnQx
	yJG3U0Vvyrs3XhqR+nzXG1dnuHK4kda0ofmIlBJ+DwQyjNQi3ByftGrO8FvmJVeI=
X-Gm-Gg: ASbGncv27nufsLFwhrISxpdDJcU13Rqr3QNTT4XdktiWQk/BWvc7ZeLrC2HwFXB8gUh
	eCeW5TtH2BOtAx4RPKk1DzmO+t/vY2v1G5yM0aaoNpKwjJW3D8NEyiSLiIJf6c6iESHNbPG6ZlH
	RKv9QCqF+cKaaTbVVZA05xKI+YguMqKj8HHdlCjKBEoxVvLEjkKsvR9GIzTC8y+my17V2A+wiCI
	p+x13+L1+G51V+l/UTGUEXuRe26DC1YWWl0c8s8MlxUQkSK/JUX1w4O3a7ZO0jnYSPy4hvv2Q8B
	UYa45jH4JO9DvBDEmYt9kzCxbPLx207HE5Xc52LjjnRRfjmKJg31
X-Received: by 2002:a17:902:ceca:b0:224:2175:b0cd with SMTP id d9443c01a7336-22428aa1c02mr211881645ad.26.1741716074121;
        Tue, 11 Mar 2025 11:01:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV1XMOUAaf3mrw2N9csl6TPk+/0MVQ+tofdzFboBXtSDMFtl99aFN84M5tc6CNvpuZXGk9IQ==
X-Received: by 2002:a17:902:ceca:b0:224:2175:b0cd with SMTP id d9443c01a7336-22428aa1c02mr211881145ad.26.1741716073692;
        Tue, 11 Mar 2025 11:01:13 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a92016sm100936345ad.190.2025.03.11.11.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 11:01:13 -0700 (PDT)
Message-ID: <fcd132af-03e4-496d-ba70-0097e90a83cf@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 11:01:09 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org,
        joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de,
        jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
        skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
        ssengar@linux.microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
        gregkh@linuxfoundation.org, vkuznets@redhat.com,
        prapal@linux.microsoft.com, muislam@microsoft.com,
        anrayabh@linux.microsoft.com, rafael@kernel.org, lenb@kernel.org,
        corbet@lwn.net
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gXoaczTLA8xgRUyE1V_yY2Hu5V5CJDA4
X-Authority-Analysis: v=2.4 cv=aptICTZV c=1 sm=1 tr=0 ts=67d07a6b cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=aMAvcm_y2WmIjkiga5kA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: gXoaczTLA8xgRUyE1V_yY2Hu5V5CJDA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=660
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110115

On 2/26/25 15:08, Nuno Das Neves wrote:
...
> +
> +MODULE_AUTHOR("Microsoft");
> +MODULE_LICENSE("GPL");
> +

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning with make W=1. Please add a MODULE_DESCRIPTION()
to avoid this warning.

This is a canned review based upon finding a MODULE_LICENSE without a
MODULE_DESCRIPTION.

/jeff

