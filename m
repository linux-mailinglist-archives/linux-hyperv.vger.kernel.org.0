Return-Path: <linux-hyperv+bounces-10260-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMxKKgwo52kf4wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10260-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 09:32:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4969B437A04
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 09:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17741300D4CF
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 07:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05458383C8C;
	Tue, 21 Apr 2026 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvHt2g/t";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVhqt+Lw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925A4175A6D
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Apr 2026 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756516; cv=pass; b=ouTozbiNybBDsZqu+i2HY0b4lBu5Saqs/Y3Rkg67deW8kcFszlxYuZjoosffjqT/V6BzOtGqMudLj0M+iQzc5FKSDkMJDMq/bDnK7gEXP29xmtGJ5cvi6AXgCyfNBdlWgJlZeNeTfBVfKXaxLT0RdbeoY00479KZobYZlZOuwjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756516; c=relaxed/simple;
	bh=wwmZXFfudo6vtD8Qyo2Fqwkv5D5eNldWMhPAPtQB018=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRWbB9ULqmBCWKqj08yvyVi5AzvUWWEsDc6iMKVbF5hsStN5Qiq+JRnaXjbngxCR2JUC10pf2ErCv3pyNr/FcMR5ht1lHBysKWmfsw/M5BdLyJKSkSbB2pSTq7UdbjQOgwaJbmznHqtfFhbyG6w2U/vIUVaVF/hETwgR8zmyjkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KvHt2g/t; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVhqt+Lw; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776756514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1NxogECpqiNsO+aGXAiC6wMG+jNg2PWSddJ9oGiQTNE=;
	b=KvHt2g/tIVJh3J2mpQlP5ias2laAXuaEHgBAzD4o+/vj3v6EQ6+lNWxEN8EIGbmbjAvpte
	I6Uhz7bZMrY5MZweV8wcyyV6uCqOa3/7LobyLG56SSFhi7jY77hL3BUlMOVrgYW4xIyh3h
	o+w1mRA7v2Q0NIIAW9NH+sZC4IjH64o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-YZj1R36JO0eRZ5ltIo1J-Q-1; Tue, 21 Apr 2026 03:28:32 -0400
X-MC-Unique: YZj1R36JO0eRZ5ltIo1J-Q-1
X-Mimecast-MFC-AGG-ID: YZj1R36JO0eRZ5ltIo1J-Q_1776756511
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fbc53b64bso4618456a91.1
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Apr 2026 00:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776756511; cv=none;
        d=google.com; s=arc-20240605;
        b=RiIB66lYDtTWUAf6ImKc0XalVdvm3TQ748vFZu788PYwj92/ERxwDxTwgZZEogER9b
         Z4bm21DQ+24Lkz4sdnZ+EuA2zVGY8fVW3Pdpd/aGHU4uMeoMH/SRZA3HU/JF/EnLNh+0
         ayfoMsZ3ktxdPEvZ3MCmg1CVQycmTsCCA6WgA4XMWyS6eg6SQfSLHgtlg5uBkvqiXW4B
         8qtftR53sT7+STMrRYvODcyhZJnnbTxsRsvZR+Odq0Bjbv/DfbruEBNF5r7USLE68e8N
         a7DtEU9QsrZnw3dFAubc3mCNtZWWWuYNoXHhMaYrev9ZpsCUnxFJzodyzG4hlL2+1W3k
         Dqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1NxogECpqiNsO+aGXAiC6wMG+jNg2PWSddJ9oGiQTNE=;
        fh=3ZuTSyr07wCorxAcM6lHp0GoP8ZFDaOZRlLUm7gS3vw=;
        b=FfCqHjSA+F1IC/TQx8QuidFZ5OBSUxyYJvw1RC7OCEFTiB9ccPfx7v10Jbm02UDvU2
         EJQj82fJctw3FQXbliSKpB7SrEyvduQAVZ2cwb8lY8b8Vx3v5AH+Vi9wiQuxYbPBq1n4
         8c1L5N9JEsuc0GLHeeVNnahf605H34xZD5wdDDpgg4LxbQ59NmGTl6jwdrpjUSU0lmE3
         1ftBvhICN80qZYSZJ/J0X7mDK0YMx67vPnZbnyhz2fNYaSOiNO1tvsTApfOwX/G9TlYH
         oNTFroqGxHXcpgQnTIWLQbgtxAoUNbhGgp3IYAv9YMZ7/la1crW1FQyF2jzNrzKXrxiU
         I69w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776756511; x=1777361311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1NxogECpqiNsO+aGXAiC6wMG+jNg2PWSddJ9oGiQTNE=;
        b=UVhqt+Lw4Baw/TvCDHMwBfj+G//AE5fZSaVch46WkQSV0EJ2vD14K+JTJrykSxPJQ2
         E3fsjwrXJj6s01fnM/PNPCM0SdQ+mw3x4OQbr76RZl30XbA/OPFShjFr6r2vCSm7glW8
         rCF+6sLQbURLm4mP7nv56qyzY8WbRY1zjjceMc2L1ZWrc7IdnRLiMAuT1Tb9PjvzlXOj
         JzdIfAxMcXgJjoGXjKXRfY9Mg4uYN1vZ+UV2WrZQ7Q7D/2svRUwyTXXYLZUBZm0zB8HI
         F1V8i6s9F74GroTnyEeVbT9RsL3ZlM8N90uMX0d04FBcyK8FX5UNB0eUwTShubuzQyVC
         QVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776756511; x=1777361311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NxogECpqiNsO+aGXAiC6wMG+jNg2PWSddJ9oGiQTNE=;
        b=AxK2P8cLa5jA/5yRa8ao6x+yBSOK05GtKbRhDLn+zStODn/oskjoHK2UI2SN0TecpW
         fvjkkAYex+5xtr45Loav10mr34FA7ceah/Ao7rXLReUIXFBoWAyAk6Es8tPQXRjfvd5D
         CXi3Lwjx3rDUosa/wOmM3li0autre5hhJwt97bBBL4AAyi2pMJxlQ7RFUqB9UsxbvHzm
         pppZZPifVIzeLjOX+pA9dU4TPeE4oLkS2i/PGx/4Yf3sfeMKWvufF35o3iA1GseHjke0
         flIVSyScjMJW6Kwe7zONOa/hus99HDxwKmogFeexiIvRlM7jL1gYZkeEkP9Hcvhwpw+L
         UBlA==
X-Forwarded-Encrypted: i=1; AFNElJ+Q3QiDGkyA9X6L6QWfGx3U/2frVsS0Qfmvf4j+Ph3g3gXF4wlEQTEvn6CR337H5JoTuSjWbmGBYyLINCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPJThCeNe+e60iGEu9aE+LF/c+9wUvKZvcmC1gnWDmhSb/ExRA
	6U3DmyNVXvxyVEUGn7YipHadZ9+g9j4O4A88AUy+jmNSq1vb9xE8Ge/EtbxW32d3cq1DUtPdcA0
	j1ElmNa6onlHdq4TAFmB7I3dSDjQ3K0Yn0ZLPaSkPuadZJ82r9DlyyFtznMp7grQj25uBITdUAO
	o4EKEWtBilVpvzJAXxrt3Fb21eEvwYrn/7p1niFnJB
X-Gm-Gg: AeBDiesv7IgzXgtRFbzATNuuvpoCDjWhRKTGYrTVJIb/e18n6iS29MW0gQEycTZCVxp
	CCKXkXkUtUnNM8fWiI3TdBSQh1LgGn963e4HAQIMCaYdn/eiwltC0vdWMX7JVqVlbQg9OSRI4Al
	agRMCP35CF91Zjwx3uOvj0iri67xv5i3Ka/Ppi5wMAbk3YVzypQ1OWPp06DyipJ66hqHGJEZExl
	vnMzAi8yVC8XlI=
X-Received: by 2002:a17:90b:4d0e:b0:35e:5ae3:298a with SMTP id 98e67ed59e1d1-36140462ad9mr17177841a91.18.1776756511197;
        Tue, 21 Apr 2026 00:28:31 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0e:b0:35e:5ae3:298a with SMTP id
 98e67ed59e1d1-36140462ad9mr17177809a91.18.1776756510684; Tue, 21 Apr 2026
 00:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416191433.840637-1-decui@microsoft.com> <177672238581.1802062.15838493180057695674.git-patchwork-notify@kernel.org>
 <SA1PR21MB69214CABCA0DCD597040F849BF2C2@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB69214CABCA0DCD597040F849BF2C2@SA1PR21MB6921.namprd21.prod.outlook.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Apr 2026 09:28:19 +0200
X-Gm-Features: AQROBzDJwpjJV5oYDv9Ov-Jk-nnVA6bAoKM78g-QgMrimqa9KxhcXRiVCwSyCjw
Message-ID: <CAGxU2F6DVcLDLg3dT5DsDmsaOuhOcD+4VSG5dqXcFRwsN1NZ+A@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2] hv_sock: Report EOF instead of -EIO
 for FIN
To: Dexuan Cui <DECUI@microsoft.com>
Cc: "patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"niuxuewei.nxw@antgroup.com" <niuxuewei.nxw@antgroup.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Ben Hillis <Ben.Hillis@microsoft.com>, 
	"levymitchell0@gmail.com" <levymitchell0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,davemloft.net,google.com,redhat.com,antgroup.com,vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-10260-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdevbpf];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4969B437A04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 at 05:13, Dexuan Cui <DECUI@microsoft.com> wrote:
>
> > From: patchwork-bot+netdevbpf@kernel.org <patchwork-
> > bot+netdevbpf@kernel.org>
> > Sent: Monday, April 20, 2026 3:00 PM
> > > [...]
> >
> > Here is the summary with links:
> >   - [net,v2] hv_sock: Report EOF instead of -EIO for FIN
> >  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=f63152958994
>
> Hi Jakub, Stefano,
> I'm sorry -- I just posted v3
>     https://lore.kernel.org/linux-hyperv/20260421025950.1099495-1-decui@microsoft.com/T/#u
> and then I realized that the v2 had been merged into the main branch :-(
>
> Should I post a new delta patch(with a Fixes tag against the v2) based on the main branch?

Ehm, I'm not sure about the process but if it's merged in net tree,
maybe we need a follow up patch.

Anyway, let's wait for Jakub's or other net maintainers' suggestions.

Thanks,
Stefano


