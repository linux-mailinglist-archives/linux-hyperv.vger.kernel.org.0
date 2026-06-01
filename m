Return-Path: <linux-hyperv+bounces-11429-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BwvAqVfHWo/ZwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11429-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:32:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB8C61D7E7
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EC8930170BB
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD1839A806;
	Mon,  1 Jun 2026 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZX6x9eiB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9Dw3W0J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB539A047
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Jun 2026 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309805; cv=none; b=LHkV0JA559OtYVv9Y+53Ey0dWdQyOvQCA5otCo7Ipm4bvzhz+ZpHPAc5wpVrI/YKilM5BOCyQN3UXX00/VoJ6bN/wzhV4zNq7G9BkBTakp10jUc15RdjaD/kgdiJ56AHiSQ1630WrttPQzxt2cfAQ4SXZYenSgiBnEG/QXKzVaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309805; c=relaxed/simple;
	bh=VfA7dbz78GZzA6BAgS32l4U/g1vSTa0ShMBVln3jJHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JvsU5440t7VTPbnWHuQUAj63gExv2w8rKbVXWmiMxpMsIB0kRb15SmcLzYeJ7Gh71g6OdumczkLZnp+V0bnzNoZrWT0TTYTXllR59H41kjVNRahUcRey2gr1tz9jaDkJSyRcx4FvqE+eQjxhstuKRH4XeqrXBIIkDkVP9kBycCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZX6x9eiB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9Dw3W0J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wi97KWGdJTdWq3IdYpsAWLx4xopc99EofOMqrefmH9Q=;
	b=ZX6x9eiBPV38y8Bjz6hiGqz3TItoF+lCpb9j6fw+st8riYtmvSsQRYg4OF3YhGc+reI/Xa
	348RIHXwT5aIiala50ZB8/GarJFHxjeF16d22Kpbt/FXc+euOfsA53i0Wfv7rAqYmfVuyB
	eR0zxHGFKuRt8YreH7uy9/zLCDPEbBk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-bmWGwwCMMUG-HJob_yJu3g-1; Mon, 01 Jun 2026 06:30:02 -0400
X-MC-Unique: bmWGwwCMMUG-HJob_yJu3g-1
X-Mimecast-MFC-AGG-ID: bmWGwwCMMUG-HJob_yJu3g_1780309801
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45eebc943bfso1906426f8f.0
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Jun 2026 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780309801; x=1780914601; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi97KWGdJTdWq3IdYpsAWLx4xopc99EofOMqrefmH9Q=;
        b=S9Dw3W0JcfrlJ8BjI0Fq3cY6Kg4KVkTsK/lHUGHmx2oc2gvQsjtafLuODOlsQjdCFi
         qUgk07Yic/Tl7HzOFJegSDlDFR1q1kt8p9CZ/V11nZ0aoMA//pXG003w7mewVf8x/fLK
         zzUv3lBPqi76mXmzWyXW6Y/iBjvfjruRvdtNDjzHnr0vx8GVhvkoTLGfc7fS6um7XaS7
         HPQbjvtUdOx3Y0sQYXKhUs4QIdnaXDH/hTfdm9+w5bUlOa/iZoq9/yQoa08GpLv+Lsbk
         Mgfzk2A8czL0itpRRboii5PAL6WlTDCjo6GzFgcJ8vh5KiFxX/mNdSp/fu1CtsjKRdKm
         F0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309801; x=1780914601;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wi97KWGdJTdWq3IdYpsAWLx4xopc99EofOMqrefmH9Q=;
        b=ihZAqSQEtaMlpKjLbpkBGxMDw6Wrssy9qcTMD+9kgdYhkAQz5H7YfWVabB9zzWeQbZ
         6ds/CX8sWTNooumjQWAgKZLPw12e0K/oC+D2J6OcEQx8fGDPNsW4VNlow/VeMEGmsrwV
         zhZvKnMJaPSKtA0bs/Ql/t0c1tSZaaavGgzKdRwUYhRZrC9kl6AzZxgka03mcb5MowTA
         94wgeXhZB+Ir2eScua9AK937FSNqWk+nTkJgwxawVVNi+/eIBEgn6PKOUuIl+J+Ad8j5
         TlsFZqcB1MBJizA0fL/L0ulnRUW7atMfspc49AaZdEW3sGONrTKNg7U7NfGH+lTJYXMN
         A6zg==
X-Forwarded-Encrypted: i=1; AFNElJ+h3UsUNPKuXjOBMd5N9d3AIxvU11QpYXPRcibWDBrNg8OSaTLDmvW85yAIzlRucAYyrwTWwHO3/cULNeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztftBq7oFvfBLccmEhFQz+NRrqw6xlaGtGMcC9JDCC8Fc43juf
	6DjLW4gfacz+2UA1rvBtzRj2AVyr3iITd6KsNY3um4KX0HVFIoL4BAFeFSUY2iUnsu87zSEQW3S
	P9v6J7uAMXfH+3NsVcnPooP9iv57sSKbrQnQz8ETlEZEY1EYHN1/EwKbr9LabAbyQFA==
X-Gm-Gg: Acq92OEWHgWYO7wl3vsdoHRwBJYcb+gzzxY5i7vLOFhJTv7ptyyCaPPGaKQ7KcjtERB
	9OT211MkgqnSH9cKgqg/sq7jgXp6HQgGoXu4E6uCbFkVq3AsnjIBMFkmh21rXsFrUr0pwQfaupu
	Eggnwy3B2zEzzL1PiMTBRlhPGmdoDtR7ygKSJapCvOP0bwHnrCFGvwmhH9tBVs9FAkhfN4Njnf4
	PZVLrCzvBII6LAMsYeE9oxC7rXQd9Hwyaeu7ss9/3twUInDX6vJ/mtNIIqCmmNcAkyU9/kfv6xc
	kpYBblwc7TOom5BorQy2wyxA9xQLZQRm0cCqY2BUuDOih6mf1CC2QBrCeZWI8luZgn9S/j3agdn
	ejSpkZXCJ3iBqMBBbsbOiY2DycMlRZikhGHBbV/mSFhaT4ABJyS5rgHorz4MARcNeARbQ7/mbKz
	zcbg7hVBzmol5E/lI=
X-Received: by 2002:a05:600c:1d0f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-490a2a22bb4mr148349775e9.6.1780309800979;
        Mon, 01 Jun 2026 03:30:00 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-490a2a22bb4mr148349225e9.6.1780309800553;
        Mon, 01 Jun 2026 03:30:00 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490af0babdcsm4375085e9.0.2026.06.01.03.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:30:00 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklinux@outlook.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 09/10] drm/damage-helper: Rename state parameters in
 damage helpers
In-Reply-To: <20260530185716.65688-10-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-10-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:29:59 +0200
Message-ID: <87bjdulfiw.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11429-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javierm@redhat.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email,broadcom.com:email,ocarina.mail-host-address-is-not-set:mid]
X-Rspamd-Queue-Id: 9FB8C61D7E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Rename some of the state parameters of the damage-helper functions to
> align them with each other and other helpers. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


