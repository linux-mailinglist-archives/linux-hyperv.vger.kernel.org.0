Return-Path: <linux-hyperv+bounces-9797-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDLxBEMCxWlZ5gQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9797-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 10:54:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCC8332B54
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 10:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E17DD30A3261
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 09:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C973537CF;
	Thu, 26 Mar 2026 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="avrMFIfO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836C377ED2;
	Thu, 26 Mar 2026 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774518253; cv=none; b=u46vxLKb/9BSwp1TIQrLEF3R0OLgqBIRUYJQSCq6vlEQXHj+ouVsd++Lo4EAcdyfwVUS26aPQ1vdltPqa8u/ANaIhfPX4HYhsdgnwBVuzdOPUw1VYrlyvmhMOAbhMvLUAHNzELw4BE3SkwIjGE9GNoP1VRQMaOTC/hl/epr4OU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774518253; c=relaxed/simple;
	bh=G7X3A1FjDM7WiH77ZcPoedDF8U0V8w19yjC2Pc1U5kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIFS2fP4+c5QdroQ5sy1RgzUYcZNgUn79uYekNBhzVi86iY3HqPDGqgZ+/PQEqe/0t3jOp94PhVrilWemoIqM2YCPMWqnoFO2E7FWwH0NAD6AYkWsdBMta0ibCMj6esKS2OQWVX54Zkxe+kviifuiAJkvW86ikhUP1zVpu7i25U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=avrMFIfO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q59Wqg1479684;
	Thu, 26 Mar 2026 09:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GQ61ku
	hdrfqFul0L2FFBXSHRCVEg6otwfwoaX1TK3/E=; b=avrMFIfOdugi4S/4hndTN+
	CLl/8HIMGz5Y/Oum5eOm3OxGCkgJK5eRyIT5itUmQlmpPCJa5rd7cEhD70kd89Vx
	sIkj70/bP26p1m99XZIqnezWszE2fOzkNLz1UKG/M+ZIpYxEchD1eZtuvPGMylcs
	oeHmw2eVFKJjsgFq0pWIzHhgjEoKzXSvm+Q3IfGfuYz/X6Rtw3ddqbg74qyboisW
	7VhJFSlPA/npMVSA1RxAqkj0qgcs/ITsZmLD/UBiIHDv6wpIicKFko9HHa1mxW7e
	FX0uQjKv616F5kTpsv6tLKCb9nFCwCPKBw3DJM+rLF0pILZ/li0SeQnt8POSnByw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqmkhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 09:43:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q70AQB026695;
	Thu, 26 Mar 2026 09:43:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m292g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 09:43:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62Q9hCts51970526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 09:43:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59BB320049;
	Thu, 26 Mar 2026 09:43:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3A6C20040;
	Thu, 26 Mar 2026 09:43:11 +0000 (GMT)
Received: from [9.52.196.90] (unknown [9.52.196.90])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 26 Mar 2026 09:43:11 +0000 (GMT)
Message-ID: <e232e227-b022-40b7-ae9b-085398172aaa@linux.ibm.com>
Date: Thu, 26 Mar 2026 10:43:11 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] s390/cio: use generic driver_override
 infrastructure
To: Danilo Krummrich <dakr@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        "K. Y. Srinivasan"
 <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Mark Brown <broonie@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini
 <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org,
        Gui-Dong Han <hanguidong02@gmail.com>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-10-dakr@kernel.org>
Content-Language: en-US
From: Vineeth Vijayan <vneethv@linux.ibm.com>
In-Reply-To: <20260324005919.2408620-10-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: lM9ihgFyzDaKKK4hT6xbAWnBu4HPvbko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2NyBTYWx0ZWRfX2in2v/sm6fVn
 1EOEfnIWW9XHJhqTtN1dackcJvrGoIn6RYtzj2jaFpMYQNlaN3XxkuZ6dzpRGfvaZaU5moxAo8x
 trr+PwJfEqlepekJSKPo1fy9d5o6sgA5m683HkjOswpiKaLB0x2ZC2oGeSCAtUXbWtftJWxMU93
 r9db17SA3IR04n61jqkqo5Bm6YDmBdYR4V4J415d1oOQfmhBzzcsrs5XSBy2lSc6eI3Yyn+zNJA
 fVQxRgkOI9yEBwUOLE+1Bp0urJ3SQpsL6Mxqh1jqv0YqiavIDSQ9i78PTJ+7C/RudgHS8T2aNad
 w9soTfL5Lep9UESaYSAmOjYsSO5EEkxvuZXANkgGYCQiRzjVScD+Gyn69Rf+vvAYsxJQFXrQuWu
 UQoghhH9HNEe1gD65ozDrx3Bl3HFNi5z9FxZxdctIbC0r4+GoaXzUaZ2fC0g/Uri9kPCKMvcMLh
 7P5IIMyCHlQF+nN31cA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c4ffb7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=rH2cy8X4UbemT2jZliAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sWD6kkjX1ahK5tMWR5AN0EWZ8NVBfHg-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260067
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9797-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,armlinux.org.uk,linuxfoundation.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vneethv@linux.ibm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 5DCC8332B54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/24/26 01:59, Danilo Krummrich wrote:
> When a driver is probed through __driver_attach(), the bus' match()
> callback is called without the device lock held, thus accessing the
> driver_override field without a lock, which can cause a UAF.
> 
> Fix this by using the driver-core driver_override infrastructure taking
> care of proper locking internally.
> 
> Note that calling match() from __driver_attach() without the device lock
> held is intentional. [1]
> 
> Link:https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/ [1]
> Reported-by: Gui-Dong Han<hanguidong02@gmail.com>
> Closes:https://bugzilla.kernel.org/show_bug.cgi?id=220789
> Fixes: ebc3d1791503 ("s390/cio: introduce driver_override on the css bus")
> Signed-off-by: Danilo Krummrich<dakr@kernel.org>
> ---

Thank you Danilo.

Reviewed-by: Vineeth Vijayan <vneethv@linux.ibm.com>

