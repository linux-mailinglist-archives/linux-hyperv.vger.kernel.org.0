Return-Path: <linux-hyperv+bounces-8791-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEMeO8qnjWkK5wAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8791-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 11:13:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B7B12C587
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 11:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 863F1303CE3C
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 10:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F10A2DFA54;
	Thu, 12 Feb 2026 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCuZ5hRP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8oDHDL+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F42DAFA8
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Feb 2026 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770891011; cv=none; b=G/On7Km62Hhb3RS5AReuZfgXY92hM0V4ee7NFC3Q0oYReK5PrQMhDR6QugugIA+nAjmriiSuhL1835HytDUCO6kRGTXHc34tIwzpczx30sTFOZESjEhy4Cj9W/10CHntRnDCvm1AJwOSAnMnTnnCJABmiLWYQVM1IPnhZCx89f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770891011; c=relaxed/simple;
	bh=SGaCcfVfOD01Cl86Knz26tLX4aJ70u9hQYfrkP4z5FM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nt0fizC5VOxONmKlDvy99P18++Y4NGB6T/a7MfWbkUCK8PA4lPDbMwsEdMSDGA5Q3ZwK2mzfQAXzjCspZtCA/Zb8IBAWBkHUvsDo4f0yHFfSeGLD4WjaLVceNbGghgFsad+DcfeDJ1XXxLHhfMmAV4wqo9488cxg33zk3bV99nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCuZ5hRP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8oDHDL+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770891009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGtZzlI0afIe1oXYIL6I39556RNwafluFe5WLDNAu60=;
	b=fCuZ5hRPPsi9frrPBgZr4n+Fj40n+pXi7ahjL3h4ICbhv9aR46ELDXQD5hg6DCg2G/6MQf
	nnSpBW4YMFcH3rGG9uOlOaw/z1SzeKqy54fEoTO40rbyf97srihrqNoykLvWBLtGhac4FI
	Pc7SNicQWOKb+sj5zC4ToIfWc9z35Sg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-Qy79SW-3MWey6xcj1L7lyw-1; Thu, 12 Feb 2026 05:10:07 -0500
X-MC-Unique: Qy79SW-3MWey6xcj1L7lyw-1
X-Mimecast-MFC-AGG-ID: Qy79SW-3MWey6xcj1L7lyw_1770891006
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4376c206493so3388969f8f.0
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Feb 2026 02:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770891006; x=1771495806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MGtZzlI0afIe1oXYIL6I39556RNwafluFe5WLDNAu60=;
        b=G8oDHDL+lGk9V1J+uwIuvYtRI0vcK8NFlpD8Yv/Hg+9H52Sqq7jpe+2v2hnNXwhPdJ
         lY7EkkAKvnl3FreULZEFDFxLt8k6mpOOoexij1IRqMpiZsep5XoMo2sXWWnEPkuv0IN+
         FNwtuOp6zIo1DFx0UFgw6oJR6qL68uK3QSkXPn6XgTTezMlNWHyQPo6nWQjlpy6+8wH4
         kLGp2qYs53qzDvV5UVcYwK5G2l3HRhpDSDpvWEbIkXs/P16O2FUkqJT53vHHjyM2st7I
         S+PnajoWNKbKXuix3l07m2p/JiroM3puD2eUEm0cBd6CyK51zQxaqtGUx8kmItg38+YM
         oK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770891006; x=1771495806;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGtZzlI0afIe1oXYIL6I39556RNwafluFe5WLDNAu60=;
        b=PGcgU0gJsGQv0JQWiKbKzZanWabP1w/xheWOaKBenuOYQaCBeS2XGd3Vo5kZbbH5hy
         nwOZzrKKmTvg5tDYIJx1q0QoFnTo9kmkhWCHoJBMW+N3l185vxUi0KZs2WbfpubAY1tr
         iX1VDMo1Y8oScZ88mcdcBhK8NRuyIScEfCJA98cnVIShPDxI83fzV3EDkfMeCmTvATV8
         9BOpEK7cU1w4ELa5vwoQFHPY7OihupX8yt7SLvSBsfgC9OhXVrXunwoyfBwwx2GuYsul
         YhG8D7azXIevtLVys325JuhQ6B61ZA1e7Js/TiFlASbV1sG4AKArVg0vwoaFSs7NnEuQ
         fw6g==
X-Forwarded-Encrypted: i=1; AJvYcCULwlKrJNE8zHK0ndtGGC0LvGgnA0gb4EprVIBWEagnsblB42tvmGYJKJAX+rAzucMU+KEA/JyAo/aRY4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeiXr/Wxd0caOk5qNjlxmYK78lgKtYJxCo2+mTA7unHJwAdZBe
	ibzsNFnwSPHYsQR7x27aL9CyubnAUStTSBOUYGWNiAtzJFxkuk56KCAvv9kVQP81QKtgH5tjhl9
	WhHr4DA/tEchPHR79Zdop/ePDsW8d7zln4KyVJSWtidIJMZBc9dkgRIoYMYG/5slW8Q==
X-Gm-Gg: AZuq6aJKzGees+NAJSiix2oqq2u7AzgdSIozXeDJnXLonoq3fN0+91FhiPG055ZlZxW
	X/Z14FFrBeJoaTpHgTqMmmfr4IXQx+mSEV5anjpxFx0tf/Fmyg4Nqqbm1UprzBomqIpTEcUzIU9
	ZUzIQhM+XvsCAvAcijxtaKRt1oIemYQvcfn/Rv0fqla6yL2l3oqv6gKMa2rd7jOdnvZXef8eIEk
	0XcahtzCatJ/2r2jABTQxs0okdPbWed1P/Uj1LInhEB+JvZbEKnxiGb/AqGdNTRBgTZKwaaZQbT
	53LTfsMqg/CAWAp7+wGQ4POJlX600c9MlUVjYTJIzeyJ3VyZfbluWKaAovA4L+XyCSlTU8zA3P0
	/dmCUOR3hABqIaZZh7qXn02/E+aOr/M8/YAMD23b+MnvmkyMAkUCEBHxV1AB5Lw==
X-Received: by 2002:a05:6000:4024:b0:436:1b1:6cbb with SMTP id ffacd0b85a97d-4378aa01106mr3209832f8f.7.1770891005914;
        Thu, 12 Feb 2026 02:10:05 -0800 (PST)
X-Received: by 2002:a05:6000:4024:b0:436:1b1:6cbb with SMTP id ffacd0b85a97d-4378aa01106mr3209788f8f.7.1770891005389;
        Thu, 12 Feb 2026 02:10:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d325f7sm11303724f8f.8.2026.02.12.02.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 02:10:04 -0800 (PST)
Message-ID: <7c6933fc-663d-4bf6-8594-c14c4be83c98@redhat.com>
Date: Thu, 12 Feb 2026 11:10:02 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/hyperv: During panic do VMBus unload after frame
 buffer is flushed
From: Jocelyn Falempe <jfalempe@redhat.com>
To: mhklkml@zohomail.com, mhklinux@outlook.com, drawat.floss@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, ryasuoka@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, stable@vger.kernel.org
References: <20260209070201.1492-1-mhklinux@outlook.com>
 <20260209070201.1492-2-mhklinux@outlook.com>
 <a5372b72-8dc0-4f2d-ad5c-086f3e75ee81@redhat.com>
 <002601dc9baa$517d8b40$f478a1c0$@zohomail.com>
 <e9d35c78-1c4b-4a9c-8cf0-9531e972279f@redhat.com>
Content-Language: en-US, fr
In-Reply-To: <e9d35c78-1c4b-4a9c-8cf0-9531e972279f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[zohomail.com,outlook.com,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,microsoft.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8791-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jfalempe@redhat.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zohomail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,patchwork.freedesktop.org:url]
X-Rspamd-Queue-Id: 54B7B12C587
X-Rspamd-Action: no action

On 12/02/2026 10:49, Jocelyn Falempe wrote:
> On 12/02/2026 00:01, mhklkml@zohomail.com wrote:
>> From: Jocelyn Falempe <jfalempe@redhat.com> Sent: Wednesday, February 
>> 11, 2026 1:54 PM
>>
>> But for this patch, the issue is that drm_panic() never gets called if 
>> CONFIG_PRINTK
>> isn't set. In that case, kmsg_dump_register() is a stub that returns 
>> an error.  So
>> drm_panic_register() never registers the callback to drm_panic(). And if
>> drm_panic() isn't going to run, responsibility for doing the VMBus unload
>> must remain with the VMBus code. It's hard to actually test this case 
>> because
>> of depending on printk() for debugging output, so double-check my
>> thinking.
> 
> Ok you're right. I changed from 
> atomic_notifier_chain_register(&panic_notifier_list, ...) to 
> kmsg_dump_register() in the v10 of drm_panic.
> 
> So I should either make DRM_PANIC depends on PRINTK, or call 
> atomic_notifier_chain_register() if PRINTK is not defined.
> 
> As I think kernel without PRINTK are uncommon, I'll probably do the 
> first solution.
> 

FYI, I just sent the corresponding change:

https://patchwork.freedesktop.org/series/161544/

Best regards,

--

Jocelyn


