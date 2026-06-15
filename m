Return-Path: <linux-hyperv+bounces-11626-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cV+xLM1jMGrrSQUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11626-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jun 2026 22:42:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BC268A01B
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jun 2026 22:42:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=d1HKdjLw;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11626-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11626-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CD8E300ED90
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jun 2026 20:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DB73B6C1D;
	Mon, 15 Jun 2026 20:42:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647BC286D5E;
	Mon, 15 Jun 2026 20:42:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781556171; cv=none; b=LbzJ/zHav9oGp4dAD8/Cz3lgPG5odrqHAd/2Y3Tua4sy9fXq5K/xwIg0EEWyppVre6QzVtafx+N60w82VgutiPzwN1JvX8tPRR4+b0cZXQb5PSK54QCcpGqSMDmY4Rr6OwJnya7TpGSdq5xoB/dMPPRi92Zhtk5bLv5yeyJnT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781556171; c=relaxed/simple;
	bh=aPTdsFC7OL8pWaV8feS5opuevgkA+VecbasCdeVpSeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnoVxxtM/NOj5nygLqssP6kZ4Fu3/XsV1hA2mtSI0jOt6bKsy5ET6pqxzDpGZ7YuLTcAt96+TxerwPvl/xp5vuxDrGTJlkbQ2KmuYuDvKVjiZ3xXxGH0YwnSzCOHUoVWgHdyqRM/NtzbopHuZLo6c9ff6ahOvOBFvW8zKtjZ34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1HKdjLw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813AE1F00A3D;
	Mon, 15 Jun 2026 20:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781556170;
	bh=nMnhxfNIZVyV93CrAHISz+K1WU9OroQwaebImzftECY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d1HKdjLwer4f02pwmKsxGAre7uZHyuXLCAFi/cGSJVg9/QJcLIjK1XgQi1MrjpW35
	 ECfZ/zEhxc2e0rSqjAXLKUqsNdX2CizYp3sUP7X7QCQKH1xDjerrukAAyjJ2dPzAGy
	 /6ZNzquNxJuNEZOVjDqDSuyOqZUjoaPvfKirr9VSIYC2ghiUz91NdW1kFYA2rDHqAE
	 zFb13JkG6klttPUh9WjcPyrX9NTacXowa/uYomdRYCTX/4z5UZ5YSSXstiqSJIzmoS
	 ahHeu5ukRiw0IvdPAj/gIEbEbCNYsLiXQTsCpNGVuB/T+5k5ogh9FOlqw9uOgiz6TA
	 Z1ikLUSwVDVnA==
Date: Mon, 15 Jun 2026 13:42:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 stephen@networkplumber.org, jacob.e.keller@intel.com,
 dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org,
 john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 yury.norov@gmail.com, pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next v10 0/2] net: mana: add ethtool private flag
 for full-page RX buffers
Message-ID: <20260615134247.0bd7e16e@kernel.org>
In-Reply-To: <ajBRwYftEol8IE49@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260602202801.1873742-1-dipayanroy@linux.microsoft.com>
	<ajBRwYftEol8IE49@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11626-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_RECIPIENTS(0.00)[m:dipayanroy@linux.microsoft.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:leon@kernel.org,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:ernis@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stephen@networkplumber.org,m:jacob.e.keller@intel.com,m:dipayanroy@microsoft.com,m:leitao@debian.org,m:kees@kernel.org,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:sdf@fomichev.me,m:yury.norov@gmail.com,m:pavan.chebbi@broadcom.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21BC268A01B

On Mon, 15 Jun 2026 12:25:53 -0700 Dipayaan Roy wrote:
> Just a gentle ping on this series. The approach was agreed upon, and it
> has picked up a few Reviewed-by tags as well.
> 
> Please let me know if you need anything else from me, or if I should
> resend it to collect the tags.

Don't recall now what the exact sequence was but pretty sure this 
no longer applied after some other mana series was merged.

