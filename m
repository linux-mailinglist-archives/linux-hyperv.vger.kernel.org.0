Return-Path: <linux-hyperv+bounces-10321-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Gr2MnTQ6Wm9kgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10321-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 09:55:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E6244E368
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 09:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1A4530059BF
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 07:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2239F26ADC;
	Thu, 23 Apr 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J24/qVdm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="no6V8h97"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3D337699
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Apr 2026 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930930; cv=none; b=iFPnLkh3y4b25iRdMBcMPboXzUoFd+b6F3YvtzkhePteot38aNtviGUXOJ6XkfYrTjI16uStQhHaZqv7CFXmES7uLrfes1MmceL8sZ9GiJ5LsdAF1OulQ/PdhvPIoKIyYeO3smefVA1/+/wmVxsXMJqqqw8BFi49h0wQQCa2XK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930930; c=relaxed/simple;
	bh=L2WN3Mdkt+PLvtN1w07nhMKHoYH38g1usozRivR3K9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ri4VXiMhKCoWHQhlww14d6y9S49kBX6peXf4RZyGwz65aMvHMCvgQHvMLQgNdh/eaoeStbqKcunFVEX0leqSrKg4eFNgRSYpFLcdM6qIMjoMklSJrpxwqayT/FQHMbD5yoas21X393RsM5BpqwvnvP7vnBrXXSgGUXt6u/zcA9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J24/qVdm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=no6V8h97; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776930927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kw0NWAnxiHM/StsVSGBC26LNQSa2ifdysLtA6b6dLbI=;
	b=J24/qVdmEajfwEEUTsN1YuwK1PjS/DGwTjnZMHaVJZqALULG8XkYk/nERa+F4ayy7faGZ1
	IXv35KoItE2TCNsE4+EGGPkev7+wM3RoJ2zLtxJqVU6Bz+WNDmPU62pg5ogpZkiqbX9E5q
	95w1VkvQeKZymTqR5S0ewKevymhfE1k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-er6sJzVmMY-6k9sIU6Rtow-1; Thu, 23 Apr 2026 03:55:26 -0400
X-MC-Unique: er6sJzVmMY-6k9sIU6Rtow-1
X-Mimecast-MFC-AGG-ID: er6sJzVmMY-6k9sIU6Rtow_1776930925
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-440d0c4401aso3758096f8f.0
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Apr 2026 00:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776930925; x=1777535725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kw0NWAnxiHM/StsVSGBC26LNQSa2ifdysLtA6b6dLbI=;
        b=no6V8h97ykgC6cpJgVuBQ/LRCYpO3tCbV/JSThKrn0vmzG6RWFJ9nmN8vP9Ma4LUvO
         q12PgayYwC/MJAY8xE6rWNIzmKcXBt0fL6TtR2r/YeEtyO4P3w9lb49fxNWqxw5llugj
         0K3fo8uJ4vL5ndRznkJII771++DWXv4GUQwVtZNHY/z3o5w9WIXOfug1EH44GSr9TT+Z
         m5q3+4CxI7jLJkggcLp2lkQ2xWTbkvMpDg1r4qIVALZhUe0HS4UD6+GkhwwKD1mm5xsr
         99uDof/2Fhve5z44DPsitcqqp7hFXBHPCIRNJp503T2aVF48D9dN+t4YUFoAeBk1g79n
         O7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776930925; x=1777535725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kw0NWAnxiHM/StsVSGBC26LNQSa2ifdysLtA6b6dLbI=;
        b=LNJBiAyCMBCP9IsfAslAv7Z7CmQR4Rz1LaUmxPWWwD26FsptqZRpWz/4TSLC4i3ce1
         eFErFnkX5oZ2i7IocKu7Zb65RykgMcIuud4I87hZwCa+uV50V0rTVTloCdbgO4k9jKtn
         qAIOE34+1AOFl883ECV9q7xGVkRkfhTQGxEXQqxm2E/FLyPB4daM2i596KCeJ3LXPgts
         NKd4jfQHX6+ObWeRvg7DrKaaDGg/8HqohgxZ9qew3cmNYqbP1OeyJ/C8FToOH2tknh41
         pBpgQUvHBxTZRF8VRLkei8xnm5w12gH5tMU7nw+pi1DNxGtk63GY3axTvRcBVag/Occ5
         5JSA==
X-Forwarded-Encrypted: i=1; AFNElJ/x90E6tivjRi8/Mx7YP2cDefsFdYS8dYHmwQN7gzG1GuqQG1Iu9q8dMPsbm+z2jLd9rlk+WjNi86zJOUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSuBHGGlLgrZiS7HtVHGN0zEH2d0UlCNxhKhhN/PU8jlVz5kdQ
	wOZzaBfMv91NcjU2FHGQ9e1xW4k5p8Ukfwx8rJ/X+wKYhqwRI57a4y09vmnPJeIwLwHSXy9iwy9
	Y72rL7qf0TcAO/ghFbZYa8FNcfLJSIkRdt2BxlIbH3N95aN8QbED5K9f20qqFMb1Zqg==
X-Gm-Gg: AeBDieu3n6cnwU1AOHSyIL3lqbqTEgyKCSpT26Qxx5PB3zqscCGNW5JcwSLt82LBPco
	A8AyL92PXJEerrKqxoA7s5ZwoxS2lKDFQCo50g9Wk/momTPvUmo1QaiDzPpLw5t4YJ6Y+ogZqn0
	3uuJgT2WsFRmcVWJFgz6QtcIvW4NlsLBdmzAZ5YevbkQ17w7sfUo+HtsSO3rxSwk2/YaFxOqtDD
	AJeakCaO3JcN/BxHAyjlq0w4CCTvug0YYWCnqX/ltep/0sBMNMGuAOtZvW1pS7+5bS6Zba3nvag
	0GB1iV7FajPq5MULKtkWBXPdpQsURbRzd0wpkxiYp94COLs9iueN2vgTlGvkKvRmRtOcLfoCvWa
	+viOlR+kWsNeesW3UfCgFIcpMJEuHAjCCqAOeIaqAs8H8Fp3WBuvIs2ojcMg8nAyh8w1gDV1Yxw
	8zfA6J2Q==
X-Received: by 2002:a05:6000:610:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-43fe3e0b4d8mr40520281f8f.22.1776930925164;
        Thu, 23 Apr 2026 00:55:25 -0700 (PDT)
X-Received: by 2002:a05:6000:610:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-43fe3e0b4d8mr40520207f8f.22.1776930924637;
        Thu, 23 Apr 2026 00:55:24 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412e36ff8bsm2933844f8f.26.2026.04.23.00.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:55:23 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:55:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	longli@microsoft.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, niuxuewei.nxw@antgroup.com, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] hv_sock: Return -EIO for malformed/short packets
Message-ID: <aenQQpYW6j0BoC69@sgarzare-redhat>
References: <20260423064811.1371749-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260423064811.1371749-1-decui@microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10321-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72E6244E368
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 11:48:11PM -0700, Dexuan Cui wrote:
>Commit f63152958994 fixes a regression, however it fails to report an
>error for malformed/short packets -- normally we should never see such
>packets, but let's report an error for them just in case.
>
>Fixes: f63152958994 ("hv_sock: Report EOF instead of -EIO for FIN")
>Cc: stable@vger.kernel.org
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
>
>Commit f63152958994 is currently only in net.git's master branch.
>
>Changes since v1:
>    Integrated comments from Stefano Garzarella:
>
>        1) access 'vsk' directly:
>           s/hvs->vsk->peer_shutdown/vsk->peer_shutdown/
>
>        2) test the error condition first and return -EIO for that.
>
>    NO other changes.

Thanks, LGTM!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


