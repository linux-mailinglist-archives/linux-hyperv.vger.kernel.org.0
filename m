Return-Path: <linux-hyperv+bounces-9732-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IARfDieMwml9ewQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9732-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 14:05:43 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D1A308E23
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 14:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FD8230D054C
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 12:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEA13845B5;
	Tue, 24 Mar 2026 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Su7gQstz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D1529D265;
	Tue, 24 Mar 2026 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357170; cv=none; b=nUGid8Ds2PVTfERIRVVDWuS5LFO/eee18sitjpkq4PLdSco8aAPbFsGw+UrJTQS5b3W/mAdUDB2NTGUVdiCyOAaE1WCvVVgxPz8fT2dyiKQ7brjGOWB1l7qpeK56uIM1t4tcNsbtYmwjxKo7ZwZSEJ23y+LIQFa1/GZlGNJes4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357170; c=relaxed/simple;
	bh=jHv8K9pMMNQ6xFjsDOLiyEic78sAfLIcZfc3vWD5W4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHX4D7uQ5MDSPMWyhyzkEox5fc3kZ0EfAvc1Dh0SglGBZF6aVxRakJp/ra/Ucsd9lo1rS0hcGk+dCS07FdCMILfTnZUry3lY7pkzrkeiwZJvfmJ+/U1QsUfWprVhEgKo1ByI8f8soEtUh5BJIwB5PYgUjVnqbj9hTuzrheICI/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Su7gQstz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O9UV8t564224;
	Tue, 24 Mar 2026 12:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ej3Isx
	3J43WHcbqsXFspxuLWGfpG7XzaDk8RnET7IuY=; b=Su7gQstz3B6aM6PFBG8uQh
	x01IvkgpF4akIkC2Yv8b74FadNo9e27ekRxXsakT3p1TARe7CZAY29h53xxd8wz1
	F4kZz+lkiD78vGhCs+laxqnB5u9xFRGK/Tsh6twYP7thvfsNIeWAGdP1jRWjsBE2
	2NrTa+0v/b8PhcVeJOs61gs29vpCXXnXjqWi5QPV0rxXNiDc7IpzG9wKPCFU1dJu
	hyIdXPUJ8IHi1NA9903kpVA7KAIe5DifhKuhpq4v9lSgLr3r1ewpvKEptBjvZ2uB
	zO3ARjeDVnRRo3nNzvOHwsDydcL2Hd5OJrLdyn0FWx65JkOT58sm1iZ5/kZyz6iA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky02vr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 12:59:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OCedC1011824;
	Tue, 24 Mar 2026 12:58:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk1pae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 12:58:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OCwtnj51904902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 12:58:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8811920063;
	Tue, 24 Mar 2026 12:58:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD0782004E;
	Tue, 24 Mar 2026 12:58:54 +0000 (GMT)
Received: from [9.52.215.154] (unknown [9.52.215.154])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 12:58:54 +0000 (GMT)
Message-ID: <43139b81-2d3a-407b-9ddf-bd42aa70f780@linux.ibm.com>
Date: Tue, 24 Mar 2026 13:58:54 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] s390/ap: use generic driver_override infrastructure
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
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Mark Brown
 <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-11-dakr@kernel.org>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260324005919.2408620-11-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwMSBTYWx0ZWRfX6N1fBrtwZrfl
 aNao0Xhwv2iPArpXTciFzlHehJzd3FqyuyxByqEu+FLvzIew8kt3PjWdYdZtO7Ev/dzu1juD33i
 ULiVxPJi+Eu3Wm01+pD7w41oOcB6CO0eS2PR+DcOqwrlrsqbZgbqKoknbOSccN4kN1AdGDnpSh4
 giT9HWCMECWpapxDaYdMQ/IXQp+iHi2011iYdnklc4+iAjB4tA8YcsPMKFTESeLitzfCKx7CeYa
 F5bfAZ1prh5bHCsbzFtvW6c4E94vHNefJ4W5xyDv5bTOpwX5xpUV089SzGXBpTCh2Tn6j/1RJAy
 8JrNkM5IZMTuuFxodSI3N0ItWWwaPezBykvTmfdz5CNBYNkZhJ/G7w4qUg5Kyf1QOlPIUBtuFZ0
 TaNFvnH1pIhI71CTLphAPYyjG3E9oMOG+wVPVi77oKaFO89fYZRslVgre89UqkZSjDGRx3OB3Tc
 tkfYq5p7x6UpUVDBiYg==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c28a95 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JtdtG7AWE7AhTqZWL1AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: umcwOVG9OGh_DW7scW8FgcsJPpy_MgAT
X-Proofpoint-GUID: iDlj1Pn5DnrzHKXcEcJoAVIWEUdMu_KQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240101
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_FROM(0.00)[bounces-9732-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,armlinux.org.uk,linuxfoundation.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dengler@linux.ibm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: A4D1A308E23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 24/03/2026 01:59, Danilo Krummrich wrote:
> When the AP masks are updated via apmask_store() or aqmask_store(),
> ap_bus_revise_bindings() is called after ap_attr_mutex has been
> released.
> 
> This calls __ap_revise_reserved(), which accesses the driver_override
> field without holding any lock, racing against a concurrent
> driver_override_store() that may free the old string, resulting in a
> potential UAF.
> 
> Fix this by using the driver-core driver_override infrastructure, which
> protects all accesses with an internal spinlock.
> 
> Note that unlike most other buses, the AP bus does not check
> driver_override in its match() callback; the override is checked in
> ap_device_probe() and __ap_revise_reserved() instead.
> 
> Also note that we do not enable the driver_override feature of struct
> bus_type, as AP - in contrast to most other buses - passes "" to
> sysfs_emit() when the driver_override pointer is NULL. Thus, printing
> "\n" instead of "(null)\n".
> 
> Additionally, AP has a custom counter that is modified in the
> corresponding custom driver_override_store().
> 
> Fixes: d38a87d7c064 ("s390/ap: Support driver_override for AP queue devices")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com


