Return-Path: <linux-hyperv+bounces-10041-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAIvD8m91GmWwwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10041-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 10:18:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1F43AB34F
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 10:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EDB5300F5E2
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 08:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A914C3939B1;
	Tue,  7 Apr 2026 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1h/t4nL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q8pyj2os"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854C38C2D0
	for <linux-hyperv@vger.kernel.org>; Tue,  7 Apr 2026 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549827; cv=none; b=YVfwuQ14TZK6fG42ANNd2qwaBR7BkjkDhVesfZc0vTiWqL86wvhcdvWW03zPpeIIO/n3c1Wph/teA28+x1GFl+2nzbHDrZF7fnSPj5cXXqZSWGWAmeCI5fDcLpH8c+/rnY/9KLNWOW4NASNqilcYKmzbxT8l2h1gpOhtAF9MfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549827; c=relaxed/simple;
	bh=hdjwIFn1qOEej0kT9LXbO92EUVDNIZ/ROtNZgj4YB9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s5d8g3Ot1xu+vMcAxI/xGKHzlXEQwu1u9xvKs5g/vK2JhI0ZOQt92//hmk+CCo0i001mukx5x7DoWYj20B+lHbbwCRMw/ODNZ59vm3hQRZ+img4AzSlf6mA8WsNOdkNAi8KaB0BtoBtV8n2y3XYEyjddrdX6e3CONyP/Oltmap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1h/t4nL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q8pyj2os; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775549825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdjwIFn1qOEej0kT9LXbO92EUVDNIZ/ROtNZgj4YB9Q=;
	b=J1h/t4nLNr0ZPHKLP09HkJ0fchjOAm7oau//002ubfUwaKSksLXaXsTjYrzvZcHjlPrbJT
	XZ9WiBgvg9F/q2mh+WzW6zcOLnNo2lSHswTtf6cBo6Qt1FjJCC1ue1rvwFbphNIpXvhNzU
	mO1vQVrDC37hl9fJTkmgX+GUesKPBAg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-osyS7K9UPNizDHjvLhCTcA-1; Tue, 07 Apr 2026 04:17:04 -0400
X-MC-Unique: osyS7K9UPNizDHjvLhCTcA-1
X-Mimecast-MFC-AGG-ID: osyS7K9UPNizDHjvLhCTcA_1775549823
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488ba2919b9so5418035e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 07 Apr 2026 01:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775549823; x=1776154623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdjwIFn1qOEej0kT9LXbO92EUVDNIZ/ROtNZgj4YB9Q=;
        b=q8pyj2os8BWHJhW2VglStlUUp7VSsVZH4TedHbxKf6JOWZG9Rq9OcDG6OWYkQtKepp
         DiL7Ji9TsGILZM2GYhA7gZjGkgG+i6W/awtTfLQ2DIP/8Stahwr/EFUMqxJTz7U2GKKA
         nlh2L33F2ey4HHvTEkR1s/JsWUmt/ckHHH/TlHOGNA8PNLXVY+uS9c4GjUmA/iErvh3F
         WwWKRFuSFZTlfr0rsPL+JkGa5k05HURaaFvw/cwhfGPYaLhKGcii+wE/QRrBFsCbj5hF
         EUcyvehcHFI9GW8nSADx5XWEmOB1nYWaBg7HwmKS4Pn1B+wdmeQU0JD3s2HLhNA/acW4
         Zklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775549823; x=1776154623;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hdjwIFn1qOEej0kT9LXbO92EUVDNIZ/ROtNZgj4YB9Q=;
        b=l0Dc5lRAp88jRtzkTpwBPo8SoQvsCyFEw+oQU3bqfvmIAmWqCVCaG3zLHaFpTi7aUq
         wh5VlbXoNjtG/tI9oFjR91TToiDh6M0zPnVe3SZ1L4rPky+PThs4pJx/xAAl/ejAPKua
         E7jkeyOPcGaMCeg16VJFQLoQG8LfTntp/sxUT/P6S82kFZnuQMRMBCQDNUj2Se/b/cIJ
         YCuc3vMBYVZD6k2RD75GBk3mEl+gZpo6d/dvREnHQB8OUKPxI8aIu+4zCubjpZMpo9fO
         LoFfSnickUPE9Iaph+/niBw+1Jeg5/jVtjq/PXU+2aFEjW59lNTLasq8HwyxZq8EJYVa
         00ww==
X-Forwarded-Encrypted: i=1; AJvYcCUCIQarvQvoJaH4OW/KKXfIArWNfG+p4hov6n9K69611Gb2W3krKWcZ5gFq+LpyxWFCI5zej7safrqSMq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLQVyKynoM7djm2LNLOp2FSZ/9b5lc2WSKYJpeDHKeh2BZl07h
	oc/JKeT+zK+vYDb47LTMIDLina2ZxKlBdheWvA+D4oWMp67s29x2iDOGSkvSDjwpGxaMKsX49dw
	j2wRpBCSRp/ISa3eTe3U+veCUO4vrs0adxLrJaWjnJaz/wS/yQ/jwrkEzITwhrvv1lDk8I7JoFR
	6uGP9+B5WAvmIRgCQekoGPbxfZRn7E9JiafBCOp5ivVkJcn5n/4yLl
X-Gm-Gg: AeBDietPnblAhFcPE5JnlfqWYvfKPvjZ5cfnglb+347JW87IsgvxiZ69BI6JQEVnwYj
	1OM0OpT8FYj7+AtqYBOTgekG16VWZhEYsjTzujb2FuD0WGh+XtFFaILV3eXyDKup2Kdgon/OaGW
	yP4ZGE1KgDDlhnSSxiFiExdYSodgWJfKI8iJOoSi2tL5u3SB6k4PCECV2U/qxySGUWK+iqyQT5A
	XMwmF1bdML5pTk39nUco5LLQxwFhmsSVmLoS3JzB15BDuXZrjG0IFVmDDUs0GfmLZH/I0TtNwlm
	uUbabWcjHASmT9oEszA9XgBXxB9KdJvTWqApN4N0DtoRoTuMWA57Y6PhrkBwMQjhfBPlJF38C3U
	NODZ6LCmbxuB+yr1muw==
X-Received: by 2002:a05:600c:314d:b0:488:bc6a:5285 with SMTP id 5b1f17b1804b1-488bc6a538bmr26277225e9.30.1775549822664;
        Tue, 07 Apr 2026 01:17:02 -0700 (PDT)
X-Received: by 2002:a05:600c:314d:b0:488:bc6a:5285 with SMTP id 5b1f17b1804b1-488bc6a538bmr26276545e9.30.1775549822144;
        Tue, 07 Apr 2026 01:17:02 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897b8176fsm183373255e9.0.2026.04.07.01.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:17:01 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Thomas Lefebvre <thomas.lefebvre3@gmail.com>, seanjc@google.com,
 pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
Subject: Re: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested
 virt due to cross-CPU raw TSC inconsistency
In-Reply-To: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
References: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
Date: Tue, 07 Apr 2026 10:17:00 +0200
Message-ID: <87v7e3mbgj.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10041-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkuznets@redhat.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA1F43AB34F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thomas Lefebvre <thomas.lefebvre3@gmail.com> writes:

...

>
> Under Hyper-V, raw RDTSC values are not consistent across vCPUs.
> The hypervisor corrects them only through the TSC page scale/offset.
> If pvclock_update_vm_gtod_copy() runs on CPU 0 and __get_kvmclock()
> later runs on CPU 1 where the raw TSC is lower, the unsigned
> subtraction wraps.
>

According to the TLFS, reference TSC page is partition wide:

"The hypervisor provides a partition-wide virtual reference TSC page
which is overlaid on the partition=E2=80=99s GPA space. A partition=E2=80=
=99s reference
time stamp counter page is accessed through the Reference TSC MSR."

so if as you say RAW rdtsc value is inconsistent across vCPUs, I can
hardly see how we can use this time source at all, even without
KVM. scale/offset are the same for all vCPUs.

I think the fix here is to avoid setting up Hyper-V TSC page clocksource
in L1. Unfortunately, with unsynchronized TSCs this will leave us the
only choice for a sane clocksource: raw HV_X64_MSR_TIME_REF_COUNT MSR
reads.

--=20
Vitaly


