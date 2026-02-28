Return-Path: <linux-hyperv+bounces-9060-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL+UMUWPomlU4AQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9060-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 07:46:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E396C1C0A17
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 07:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D0F23051D34
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 06:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133C845038;
	Sat, 28 Feb 2026 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEe25Xzf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215A368961
	for <linux-hyperv@vger.kernel.org>; Sat, 28 Feb 2026 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772261187; cv=pass; b=flEipfIkdpYPEVHxbs9DAm2GYkElxd3oSlAgUEn4TffBynsYf5tXxJVJote4Aemp8vHIT/c1zCzcX5ykoqiQT14mM88zHF1T4jnQg30lkPj17AyH4iHM9pMCqncpkSYzT1bjER2vfCMIStO927RRmaeJ1fj6K3i/CrMUa7beZJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772261187; c=relaxed/simple;
	bh=/wS2wjTe3JSrdVNqqsGlaUqUm1j9PE+xLuCzuXq1Ixw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/+4niGkTLn6EJCBuqbRKKFEjxsz5XOjY6sX+KbV6prG2YW1OYHogF2dIgDlwIXQDnFiC9Dib8TUcfwy4LAddBNOjfyPrzABLucPGsZVSf7ErtLZEf5B+SKpgbvffaubAYeUhMKV65L5HXwa+5Bh52ZGnckgFZ3pmK+/11LmVWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEe25Xzf; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-389ff3f41f8so10829521fa.3
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 22:46:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772261184; cv=none;
        d=google.com; s=arc-20240605;
        b=a8gS8xNLOMFOzh4HdPUSwKfPWdguPhiJ/DOv4x1DKASVJ+0sE/75HCNINrEWtKe4c+
         WhAu/8IsA7mzee4ZbwnG+FKlhc8G57bHDNhSJLbfI0IOhe9bYEu6gqohK6DFZQAopvKP
         ToAv5X1f+xQvjUuYprqe1GhHjz+SfA6qY0y0X+oPGgQ9K403+6VPrhAC7hSINI9utrEz
         VJ8yN+R0Vw1uP02mZKtvoOaDy5cdNbg5gfoifJ3QuGDDj8Stz4zy119lTyG0N8/zT+OX
         j+w/qxTnb7RtQlPEpAwCMomw1BfxcyCu2r/iMe8nTieRKN+9HF6lKOymvnEPvMQA1rpn
         WPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/wS2wjTe3JSrdVNqqsGlaUqUm1j9PE+xLuCzuXq1Ixw=;
        fh=2mWpGssM8sLi75wJ3jouD/HHLvQhREaGerT7p8gC2Gk=;
        b=iNz0vBMmA0VyfCY1RKaKuHNNX3BeTSiKxhLSZT/rSAolcgjklLtvTQhjisRRQ72a2H
         lxxvyYyKpoYNnzCFrA3M/Ficd2MIX2ch/+EeZ1nUaaEERhNJvkiN0rdKMKJa7XCcbU71
         Ej8h8yVxFYRCUtoZzugHRuHt8jOZSRwIgZiKBtuo0LAK76Ja5/1AUPvfS/DzEAVK27ft
         CNyRl+wojEzkJOOv3uaYXJQEeV54aMaPZMWZHq01x6gQLJ8jxMlK55HrbHALlM2Rzcuq
         ooLlttUgY8RVhU1cWeByQBQV4DI8U1k07kK/O+56NQPhO0j/tXFpQOGKoUSM0lllY85D
         0h7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772261184; x=1772865984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wS2wjTe3JSrdVNqqsGlaUqUm1j9PE+xLuCzuXq1Ixw=;
        b=GEe25Xzf6aLhHexquB69J0F5UBSSo9zZsCrdk/XMOS3q6wPel4j6MR9Om5LEX6Hu4U
         pyYd02A7S3Q8JykFI29B6Nwm3mH0giNTTj5TQRv2EpqqStbB+oQIrbzAESfHTPqitzqd
         eqSadyBSCBHfGg7OwmuPxC68I2nrvB07bLeUc4/0riFX0GCaq2dvSILluDE8kKKT38Vk
         eHVSCgX1VcXUvxkUZQA5djr/qXZ8BaAS7nqXksykN5/bTJyIvL4OoFRP/SxyToP6KD2G
         xkx8+1wvNRogjxWKRYjsyssYnnG4g8S/sLZnNjEfyIWus4XGWOyzmfD4q0V9FmBIhgNt
         RCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772261184; x=1772865984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/wS2wjTe3JSrdVNqqsGlaUqUm1j9PE+xLuCzuXq1Ixw=;
        b=kLf2tWNsWAQl6xxM+PibV1VjxFO2STiCoQXNxSKh/ISzCf0YnaZb1rfGiZH2H+DNiI
         IpbsJVH27NBnlLnD9xuHYd+8n35Xq1jN7JeV0opFWgdH0kSWDVS78thSBGZRjyLi3gyQ
         OFe7kUtIB/6grEQtcbQVul0DatXmHNLF45pesarDQrkU64hNGpsV+UdipBmqlJUi3WPz
         lvdACoB2tw90Qg3UsMCPX3ZMWbFlEIDimprS9H4WG8W7TxLRtwWXLVVF0dUmmkMl7wbE
         +lBQq/BNR59QEbWNKiy4jajGss18Fd4b4LvxP2DgB5rf7ME5icU9t8xvS/GmoI1ZfB3S
         R42g==
X-Forwarded-Encrypted: i=1; AJvYcCU4at67sIBF47PRGayI6hgPFHYVFcCp94GdN5gqtrtLoVg89QPhX+RFuXNneWQI4K7uHr6YYnDplHUHd/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzheDSduENg1j3iW7kVhEgfsTJCMdzU9hi0Pp2BBiwQlQ/ZeXEk
	eE2iMVs471JS2U4dc9PZfoIHCw0ZV+rUDpE7MLPLsMW5pbUpW3STUaVefWW3uCamU8rkeTEGQpF
	NwSIyMN+A6rfpYtzq0CKE6BtacgFUh9A6CjLH
X-Gm-Gg: ATEYQzwShJxhuxdbNeu3yMW1vStJf1EFqZZgq0id9m21Q6Hov0muJLQVlIIlFXbLNV/
	KtXpGcO4WLDn9hl3muWztzDJeJLGi0/1eFhe/qgaFPsVCXiBsIYpswbq2CS9uxnPwr/IsiAZTas
	VztY6nJsXAxC9kTzlhe2V3XGgjYg1yLl5A4i6JpthhQ+vxa2V78Hf9z/RU1a0c/YTIfxXRSQURl
	AzjhC+7mxJNaiFc+71sS09kdXuaYlcGlQidOtJsKVcRfdCx6L7ONjYRxzsyRTN6VVzPeNim68Ho
	Vk2C1QEim9j26pXjpkeaEVRxTPDYbLDChFp0XLFd0id2ZvsDgdyV5sNkX57YhPn9tqJUacmw2JI
	tipeKsYZcy7nTXcZ8uh+WqsSoe1XAahxx
X-Received: by 2002:a05:651c:1615:b0:389:f5b4:46cc with SMTP id
 38308e7fff4ca-389ff119546mr39183481fa.4.1772261183610; Fri, 27 Feb 2026
 22:46:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227224030.299993-2-ardb@kernel.org>
In-Reply-To: <20260227224030.299993-2-ardb@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 28 Feb 2026 07:46:13 +0100
X-Gm-Features: AaiRm52h5eqz9SXXmbj3Sh2GPSVuVH1hZQXzL_S5L8Ru29VkR79ZCJ7Ab58mk_A
Message-ID: <CAFULd4ajL3P=-8bfoER8LijDZGAim_oyvza_GPk6C4zQ8N__ww@mail.gmail.com>
Subject: Re: [PATCH v2] x86/hyperv: Use __naked attribute to fix stackless C function
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Mukesh Rathor <mrathor@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9060-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E396C1C0A17
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 11:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> hv_crash_c_entry() is a C function that is entered without a stack,
> and this is only allowed for functions that have the __naked attribute,
> which informs the compiler that it must not emit the usual prologue and
> epilogue or emit any other kind of instrumentation that relies on a
> stack frame.
>
> So split up the function, and set the __naked attribute on the initial
> part that sets up the stack, GDT, IDT and other pieces that are needed
> for ordinary C execution. Given that function calls are not permitted
> either, use the existing long return coded in an asm() block to call the
> second part of the function, which is an ordinary function that is
> permitted to call other functions as usual.
>
> Cc: Mukesh Rathor <mrathor@linux.microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Uros Bizjak <ubizjak@gmail.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: linux-hyperv@vger.kernel.org
> Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection int=
o vmcore")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2: apply some asm tweaks suggested by Uros and Andrew

Acked by: Uros Bizjak <ubizjak@gmail.com>

FYI: GCC by design inserts ud2 at the end of x86 naked functions. This
is intended to help debugging in case someone forgets ret/jmp, so
program execution does not wander into whatever follows the function.
IIRC, when ud2 follows ret, code analyzers may report "unreachable
code" warnings. I don't know if this is still the case, but
nevertheless this should be considered an important "safety net"
feature of the compiler.

Uros.

