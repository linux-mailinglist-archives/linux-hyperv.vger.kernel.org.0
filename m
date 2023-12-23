Return-Path: <linux-hyperv+bounces-1365-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AC881D30F
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Dec 2023 09:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495751F220CE
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Dec 2023 08:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC08BF2;
	Sat, 23 Dec 2023 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVvJjoVB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F758BE0
	for <linux-hyperv@vger.kernel.org>; Sat, 23 Dec 2023 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703318741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RUBshkXYLnMOjBb5DKpZF415KAW7AprSbIw5W2JKUNk=;
	b=IVvJjoVBejdv3WALQXNuWRqR2QSS+iVdVRcqLhO9GcvsO68ChutGUGfc86WH6LFbrENlvN
	ZERUtXgao7P6PNssMqsZTPFkLJrdDgOdcXVXaSNp7B+a3vxKuyH+Uf7R50KmDenYvGlp6P
	YuzFD+NaxAM3PD5Cp5PI3Evo7TxJKcQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-2qVpIdo1PUy1r3rCWk-j4w-1; Sat, 23 Dec 2023 03:05:39 -0500
X-MC-Unique: 2qVpIdo1PUy1r3rCWk-j4w-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-55438197a50so751936a12.1
        for <linux-hyperv@vger.kernel.org>; Sat, 23 Dec 2023 00:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703318738; x=1703923538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUBshkXYLnMOjBb5DKpZF415KAW7AprSbIw5W2JKUNk=;
        b=lr81OXcfnLy0rUFS8kKI8RmnRsD0NOoZtGEiZPoDUxXXNQfwRSPSC17XZMBfu18CGD
         su8TFj6jdRIS9N0+vGqn2IuS1xPStmV0UwF8Fis1EDTW1wvIDilxN+Rc18RB6ZSg4s9W
         NiV4L+Lpa7MkQnu3/DnLI7uzqJcPZNCJ6r6rGFlqKDb+whlqtLaabi+OKkNetCv9766T
         t1snZ/JJnVNtwq4bL5e2iQzFvysRmsz1zFwes6kzLcQRb8oyu6NrYCJZnLESD+McIcT6
         /XaxvLhUmgJUQfv8r+eAiAQkHtS5KCzdBCl7z53wGdghf6LdwRse73/A7gAmxtcbsZW5
         JReQ==
X-Gm-Message-State: AOJu0Yzp2UTU3BZvCWzP71mFYZvDYaHYiulEjVIJpm1+qM0GK3j/uGoW
	TQAJxUWpNAY0xZc3UZ6avI9dgYwmngAqJY3R84VeItIU7BAbhaq88yrE6/D1f8LEGrQzXg67GtR
	HaG3ittO2M3IfUtqqqoddQ+oDy1UtyofNwbuM5FymkMBSxvC3
X-Received: by 2002:a50:c34d:0:b0:553:a1e0:311f with SMTP id q13-20020a50c34d000000b00553a1e0311fmr1606631edb.25.1703318738388;
        Sat, 23 Dec 2023 00:05:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHJdTN/u/DmP7Uvbt5/cBKSo9kCI2NkUXyLgyM//v5EmWOM390R9Q+ypDdpDISQLMLvG/fGzDYCHyI3Jl0b+8=
X-Received: by 2002:a50:c34d:0:b0:553:a1e0:311f with SMTP id
 q13-20020a50c34d000000b00553a1e0311fmr1606615edb.25.1703318738035; Sat, 23
 Dec 2023 00:05:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1696847920-31125-1-git-send-email-shradhagupta@linux.microsoft.com>
 <A8905E07-2D01-46D6-A40D-C9F7461393EB@redhat.com> <CAK3XEhMzLvxTbP+sFjD7btfdjw5uxyAccdT09d4hcw5hkCKXHQ@mail.gmail.com>
In-Reply-To: <CAK3XEhMzLvxTbP+sFjD7btfdjw5uxyAccdT09d4hcw5hkCKXHQ@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 23 Dec 2023 13:35:26 +0530
Message-ID: <CAK3XEhOn+k7U88sMF2tXGSyhYvAL9u17sw6qvomL=oYESRMQkw@mail.gmail.com>
Subject: Re: [PATCH v8] hv/hv_kvp_daemon:Support for keyfile based connection profile
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Olaf Hering <olaf@aepfle.de>, 
	Shradha Gupta <shradhagupta@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 12:43=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wr=
ote:
>
> On Fri, Oct 13, 2023 at 3:06=E2=80=AFPM Ani Sinha <anisinha@redhat.com> w=
rote:
> >
> >
> >
> > > On 09-Oct-2023, at 4:08 PM, Shradha Gupta <shradhagupta@linux.microso=
ft.com> wrote:
> > >
> > > Ifcfg config file support in NetworkManger is deprecated. This patch
> > > provides support for the new keyfile config format for connection
> > > profiles in NetworkManager. The patch modifies the hv_kvp_daemon code
> > > to generate the new network configuration in keyfile
> > > format(.ini-style format) along with a ifcfg format configuration.
> > > The ifcfg format configuration is also retained to support easy
> > > backward compatibility for distro vendors. These configurations are
> > > stored in temp files which are further translated using the
> > > hv_set_ifconfig.sh script. This script is implemented by individual
> > > distros based on the network management commands supported.
> > > For example, RHEL's implementation could be found here:
> > > https://gitlab.com/redhat/centos-stream/src/hyperv-daemons/-/blob/c9s=
/hv_set_ifconfig.sh
> > > Debian's implementation could be found here:
> > > https://github.com/endlessm/linux/blob/master/debian/cloud-tools/hv_s=
et_ifconfig
> > >
> > > The next part of this support is to let the Distro vendors consume
> > > these modified implementations to the new configuration format.
> > >
> > > Tested-on: Rhel9(Hyper-V, Azure)(nm and ifcfg files verified)
> >
> > Was this patch tested with ipv6? We are seeing a mix of ipv6 and ipv4 a=
ddresses in ipv6 section:
>
> There is also another issue which is kind of a design problem that
> existed from the get go but now is exposed since keyfile support was
> added.
> Imagine we configure both ipv6 and ipv4 and some interfaces have ipv4
> addresses and some have ipv6.
> getifaddres() call in kvp_get_ip_info() will return a linked list per
> interface. The code sets ip_buffer->addr_family based on the address
> family of the address set for the interface. We use this to determine
> which section in the keyfile to use, ipv6 or ipv4. However, once we
> make this decision, we are locked in. The issue here is that
> kvp_process_ip_address() that extracts the IP addresses concatenate
> the addresses in a single buffer separating the IPs with ";". Thus
> across interfaces, the buffer can contain both ipv4 and ipv6 addresses
> separated by ";" if both v4 and v6 are configured. This is problematic
> as the addr_family can be either ipv4 or ipv6 but not both.
> Essentially, we can have a situation that for a single addr_family in
> hv_kvp_ipaddr_value struct, the ip_addr member can be a buffer
> containing both ipv6 and ipv4 addresses. Notice that
> process_ip_string() handles this by iterating through the string and
> for each ip extracted, it individually determines if the IP is a v6 or
> a v4 and adds "IPV6ADDR" or "IPADDR" to the ifcfg file accordingly.
> process_ip_string_nm() does not do that and solely makes the
> determination based on is_ipv6 values which is based on a single
> addr_family value above. Thus, it cannot possibly know whether the
> specific IP address extracted from the string is a v4 or v6. Unlike
> for ifcfg files, fir nm keyfiles, we need to add v4 and v6 addresses
> in specific sections and we cannot mix the two. So we need to make two
> passes. One for v4 and one for v6 and then add IPs in the respective
> sections.
>
> This issue needs to be looked into and unless it's resolved, we cannot
> support both ipv4 and ipv6 addresses at the same time.

In the short term, we should probably do this to avoid the mismatch :

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 318e2dad27e0..b77c8edfe663 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -1216,6 +1216,9 @@ static int process_ip_string_nm(FILE *f, char
*ip_string, char *subnet,
                                                       subnet_addr,
                                                       (MAX_IP_ADDR_SIZE *
                                                        2))) {
+               if (is_ipv6 =3D=3D is_ipv4((char*) addr))
+                   continue;
+
                if (!is_ipv6)
                        plen =3D kvp_subnet_to_plen((char *)subnet_addr);
                else

But this is really a short term hack.


