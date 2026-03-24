Return-Path: <linux-hyperv+bounces-9731-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FQlNUSJwmkLewQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9731-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 13:53:24 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFC3308B3B
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 13:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 615C5306A048
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B758F3F8DE0;
	Tue, 24 Mar 2026 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nqs3h6Sk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A91D3F54BD;
	Tue, 24 Mar 2026 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356141; cv=none; b=XZctvoahhBals+jVaKwZquEEr+K/QtUVRNnfXrMev77fOvNVfLFYx/C0dtaaynh7C1UQLd2GERMZ0L421yafi7Bu+CmIhF4CVKYgxEqnOkdBj9PPPfRxC56VTpcKZJWVbxVz/GtS0XFCVhsQSX8DzNkoH/yvpEFv7RDryeqRzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356141; c=relaxed/simple;
	bh=qoquiz1TfLoJSq0TulMqWFGIEKMZcggZYXoiuuXxM5I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MpOlsNKSh8GKMYPKdzJvtDcD3UEww40e97lF11R14DHSp75TsSWht5LQ+Aa0cGJQGlvf6GSnQMhfw/m6/UpGzfOlzht/hKKpppJfnZ/QW0tBViDQRQgY9hxbHCXtgQiVo+3IDstH42wkWf7TGlRkEA7bqMu17pseK83tLXBVk/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nqs3h6Sk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O7DT6Q481575;
	Tue, 24 Mar 2026 12:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=Shk48Guqth0dMGtPHiYWn3blJ70CgjGVRZHzaVpvLPY=; b=nqs3h6SkcQWZ
	+OwoltQeMxOO6RblQPqe55tAVjsackvCM4KkhWNpCQq04FPsFlS93zfiGSC7Di4+
	S9HKMl0Sjn5QTzbM3NfhhnAIAYBvkUkrdxOKSw7d0UM43AXyYRkeT8yYGAz8hak7
	ZGJjdVwyS8NI2NFgL8wvwtd0s6FHAxSN4ucTbH9O2vRt2+dg7MkFcwB5Thprjrjc
	U/howCgydGuthvICdFGdQd3XIc0EaU0k/lS6es2878jUgr/pm+7/onljXHYAZGv+
	d2SOZp5c+3ZgwIjW+EEdkE2KjadPhRrKOtZM1Zuf8LiFRmTbl3wfp/kpxlXGAEqB
	O8U48KsXUA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxudx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 12:41:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OC7Gcu008722;
	Tue, 24 Mar 2026 12:41:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnhuw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 12:41:30 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OCf5V326608298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 12:41:05 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 201225803F;
	Tue, 24 Mar 2026 12:41:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 946D658055;
	Tue, 24 Mar 2026 12:41:25 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 12:41:25 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Mar 2026 13:41:25 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ioana
 Ciornei <ioana.ciornei@nxp.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil
 Agarwal <nikhil.agarwal@amd.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan
 Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
        Bjorn Helgaas
 <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Mark Brown
 <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang
 <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Alex Williamson
 <alex@shazbot.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini
 <sstabellini@kernel.org>,
        Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>,
        "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,
        linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/12] s390/ap: use generic driver_override infrastructure
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260324005919.2408620-11-dakr@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-11-dakr@kernel.org>
Message-ID: <b5a80e06aa0240348dfa6826c20f3aec@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c2867c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=V8-k01nbhAtxNRQPXScA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA5OCBTYWx0ZWRfX5BtF+dGcqKne
 ud3qOj4gTSLR9zLNfAq3JG6g/oOlaoDuAoL5ugYqpH9s9vpJjplhqsv+C5Fn13wLfcNuqTFjG2K
 8B20fOIVvCqa5XvNqyGQnMAHAZ9m7lornaYpmzRxy2uj+A1xP4iQsysQ7y+S7A488UAEKXq5qZ6
 LBbN3vhPXZJ/bEjV349pY7YewQW80X8aJiv4wUe79X39dz6GUwBnh+wAamLPOldfeVWA3ylebkO
 fpE77uN6WRT54jS8FnW/ZhUlXkVn14gcYRIyrgSPpzwxEiZ3nS5fgK7DV0UKCoQQHx0EyIcKLvI
 sxcDzd1vSEY19GMOKPv1ZW+MN86TCAn4dq3ojgq1Xg0hwRVL0L3YGoz9QETDntcaSlj/0kKtlA6
 UfD/yUxgwr0WFEGPDCZ3E/gq/ajxwH4hTrddRdALUSslhqrcmAjUB1i/qil1QJJkf8vWuRKoJjs
 AJigNCQkv9LzvxCAnUQ==
X-Proofpoint-GUID: YK3KYDPHgye9e3NvrRpemo-oOEIjjzeD
X-Proofpoint-ORIG-GUID: IG7OyOmEsbO9ZGMbJn71CzQus0Ee1qWf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240098
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9731-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[armlinux.org.uk,linuxfoundation.org,kernel.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:replyto,linux.ibm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[freude@linux.ibm.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[freude@linux.ibm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 2CFC3308B3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-24 01:59, Danilo Krummrich wrote:
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
> Fixes: d38a87d7c064 ("s390/ap: Support driver_override for AP queue 
> devices")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/s390/crypto/ap_bus.c   | 34 +++++++++++++++++-----------------
>  drivers/s390/crypto/ap_bus.h   |  1 -
>  drivers/s390/crypto/ap_queue.c | 24 ++++++------------------
>  3 files changed, 23 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/s390/crypto/ap_bus.c 
> b/drivers/s390/crypto/ap_bus.c
> index d652df96a507..f24e27add721 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -859,25 +859,24 @@ static int
> __ap_queue_devices_with_id_unregister(struct device *dev, void *data)
> 
>  static int __ap_revise_reserved(struct device *dev, void *dummy)
>  {
> -	int rc, card, queue, devres, drvres;
> +	int rc, card, queue, devres, drvres, ovrd;
> 
>  	if (is_queue_dev(dev)) {
>  		struct ap_driver *ap_drv = to_ap_drv(dev->driver);
>  		struct ap_queue *aq = to_ap_queue(dev);
> -		struct ap_device *ap_dev = &aq->ap_dev;
> 
>  		card = AP_QID_CARD(aq->qid);
>  		queue = AP_QID_QUEUE(aq->qid);
> 
> -		if (ap_dev->driver_override) {
> -			if (strcmp(ap_dev->driver_override,
> -				   ap_drv->driver.name)) {
> -				pr_debug("reprobing queue=%02x.%04x\n", card, queue);
> -				rc = device_reprobe(dev);
> -				if (rc) {
> -					AP_DBF_WARN("%s reprobing queue=%02x.%04x failed\n",
> -						    __func__, card, queue);
> -				}
> +		ovrd = device_match_driver_override(dev, &ap_drv->driver);
> +		if (ovrd > 0) {
> +			/* override set and matches, nothing to do */
> +		} else if (ovrd == 0) {
> +			pr_debug("reprobing queue=%02x.%04x\n", card, queue);
> +			rc = device_reprobe(dev);
> +			if (rc) {
> +				AP_DBF_WARN("%s reprobing queue=%02x.%04x failed\n",
> +					    __func__, card, queue);
>  			}
>  		} else {
>  			mutex_lock(&ap_attr_mutex);
> @@ -928,7 +927,7 @@ int ap_owned_by_def_drv(int card, int queue)
>  	if (aq) {
>  		const struct device_driver *drv = aq->ap_dev.device.driver;
>  		const struct ap_driver *ap_drv = to_ap_drv(drv);
> -		bool override = !!aq->ap_dev.driver_override;
> +		bool override = device_has_driver_override(&aq->ap_dev.device);
> 
>  		if (override && drv && ap_drv->flags & AP_DRIVER_FLAG_DEFAULT)
>  			rc = 1;
> @@ -977,7 +976,7 @@ static int ap_device_probe(struct device *dev)
>  {
>  	struct ap_device *ap_dev = to_ap_dev(dev);
>  	struct ap_driver *ap_drv = to_ap_drv(dev->driver);
> -	int card, queue, devres, drvres, rc = -ENODEV;
> +	int card, queue, devres, drvres, rc = -ENODEV, ovrd;
> 
>  	if (!get_device(dev))
>  		return rc;
> @@ -991,10 +990,11 @@ static int ap_device_probe(struct device *dev)
>  		 */
>  		card = AP_QID_CARD(to_ap_queue(dev)->qid);
>  		queue = AP_QID_QUEUE(to_ap_queue(dev)->qid);
> -		if (ap_dev->driver_override) {
> -			if (strcmp(ap_dev->driver_override,
> -				   ap_drv->driver.name))
> -				goto out;
> +		ovrd = device_match_driver_override(dev, &ap_drv->driver);
> +		if (ovrd > 0) {
> +			/* override set and matches, nothing to do */
> +		} else if (ovrd == 0) {
> +			goto out;
>  		} else {
>  			mutex_lock(&ap_attr_mutex);
>  			devres = test_bit_inv(card, ap_perms.apm) &&
> diff --git a/drivers/s390/crypto/ap_bus.h 
> b/drivers/s390/crypto/ap_bus.h
> index 51e08f27bd75..04ea256ecf91 100644
> --- a/drivers/s390/crypto/ap_bus.h
> +++ b/drivers/s390/crypto/ap_bus.h
> @@ -166,7 +166,6 @@ void ap_driver_unregister(struct ap_driver *);
>  struct ap_device {
>  	struct device device;
>  	int device_type;		/* AP device type. */
> -	const char *driver_override;
>  };
> 
>  #define to_ap_dev(x) container_of((x), struct ap_device, device)
> diff --git a/drivers/s390/crypto/ap_queue.c 
> b/drivers/s390/crypto/ap_queue.c
> index 3fe2e41c5c6b..ca9819e6f7e7 100644
> --- a/drivers/s390/crypto/ap_queue.c
> +++ b/drivers/s390/crypto/ap_queue.c
> @@ -734,26 +734,14 @@ static ssize_t driver_override_show(struct device 
> *dev,
>  				    struct device_attribute *attr,
>  				    char *buf)
>  {
> -	struct ap_queue *aq = to_ap_queue(dev);
> -	struct ap_device *ap_dev = &aq->ap_dev;
> -	int rc;
> -
> -	device_lock(dev);
> -	if (ap_dev->driver_override)
> -		rc = sysfs_emit(buf, "%s\n", ap_dev->driver_override);
> -	else
> -		rc = sysfs_emit(buf, "\n");
> -	device_unlock(dev);
> -
> -	return rc;
> +	guard(spinlock)(&dev->driver_override.lock);
> +	return sysfs_emit(buf, "%s\n", dev->driver_override.name ?: "");
>  }
> 
>  static ssize_t driver_override_store(struct device *dev,
>  				     struct device_attribute *attr,
>  				     const char *buf, size_t count)
>  {
> -	struct ap_queue *aq = to_ap_queue(dev);
> -	struct ap_device *ap_dev = &aq->ap_dev;
>  	int rc = -EINVAL;
>  	bool old_value;
> 
> @@ -764,13 +752,13 @@ static ssize_t driver_override_store(struct 
> device *dev,
>  	if (ap_apmask_aqmask_in_use)
>  		goto out;
> 
> -	old_value = ap_dev->driver_override ? true : false;
> -	rc = driver_set_override(dev, &ap_dev->driver_override, buf, count);
> +	old_value = device_has_driver_override(dev);
> +	rc = __device_set_driver_override(dev, buf, count);
>  	if (rc)
>  		goto out;
> -	if (old_value && !ap_dev->driver_override)
> +	if (old_value && !device_has_driver_override(dev))
>  		--ap_driver_override_ctr;
> -	else if (!old_value && ap_dev->driver_override)
> +	else if (!old_value && device_has_driver_override(dev))
>  		++ap_driver_override_ctr;
> 
>  	rc = count;

Thanks Danilo
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>

