Return-Path: <linux-hyperv+bounces-1364-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7D681D2D3
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Dec 2023 08:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE6AB23472
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Dec 2023 07:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41EE9441;
	Sat, 23 Dec 2023 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VloHOJCd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013449440
	for <linux-hyperv@vger.kernel.org>; Sat, 23 Dec 2023 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703315622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=squQ29LS3om98KbFUvaUmQ9St+SmyXFv/Z9gYa40yWE=;
	b=VloHOJCd3dJ+Nfp57WePRvpFMswkEYFwqdgkm60Non5xXM72PKpiPNt84wKDZAN9g/aVAi
	VKj/R7kdTTtIixymaNb0lf44qj8m5BcBN5mPETaK4x91EnJf9D6PRrgundg7afEDMSqVEG
	NHAN6KFuOR7qoOL6Dn6AH0cuXrxinfE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-yBwaAkxYNwOukn5xjsH2mQ-1; Sat, 23 Dec 2023 02:13:41 -0500
X-MC-Unique: yBwaAkxYNwOukn5xjsH2mQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a2336591d48so121594166b.3
        for <linux-hyperv@vger.kernel.org>; Fri, 22 Dec 2023 23:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703315620; x=1703920420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=squQ29LS3om98KbFUvaUmQ9St+SmyXFv/Z9gYa40yWE=;
        b=bToX6GTRBkehMORuS+LmF7UsJLJsDLfgr+4gmwbNsIRejf4Dw4+PjJ/0NVR0Xrl83i
         jVWAAXvtV1bLRB8RlWYQxIXpaRYDskv2TzNiTG1eR6MLOwzHF1gXYcMMMZrlTQE5/2/B
         /uiG+/skNVSNStTHkhRMDLNdGTN3QngfCf3+KehakpeQqwLqUGKkm+I49E1bYV+gwTwI
         GaYIDJdKHtWuMfMmSeNWv9a/IUC0Te0LD1OkRjTJI6XDODeKrmVD/55iPo6cMpRQur6o
         SFe3RZWIJVFp9xEIzuE7CY23neVD4fc7w2D5MsRC/STO/oAoSYmyJrBnX2ncOfS0FMs0
         p3lg==
X-Gm-Message-State: AOJu0YxCjicZzF+3uTR+nusHZjXB0htz7LIsE3DquLqb7PsDq1DUD/nF
	nXDqYxyfnxivcdylzP7HObsVcsnUyUbwE3lzigMBIrlJJv4A/UJN+JqzdugpDJF97H5iMYM6glS
	dPnKh6F7ROVEDujBLYxhyN7PU6DURBMCW0O8iTama1oRjpZsM
X-Received: by 2002:a17:906:1407:b0:a24:20f:d63a with SMTP id p7-20020a170906140700b00a24020fd63amr1383530ejc.97.1703315620195;
        Fri, 22 Dec 2023 23:13:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYEMBBT5Zw58uO7AdGyGk7/pEuqfRVBPHrUuH9cZkOOYZHJE9QLK4Rz/ermUvC5DihlRZy0a1AG5+DeW8vH0k=
X-Received: by 2002:a17:906:1407:b0:a24:20f:d63a with SMTP id
 p7-20020a170906140700b00a24020fd63amr1383516ejc.97.1703315619891; Fri, 22 Dec
 2023 23:13:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1696847920-31125-1-git-send-email-shradhagupta@linux.microsoft.com>
 <A8905E07-2D01-46D6-A40D-C9F7461393EB@redhat.com>
In-Reply-To: <A8905E07-2D01-46D6-A40D-C9F7461393EB@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 23 Dec 2023 12:43:28 +0530
Message-ID: <CAK3XEhMzLvxTbP+sFjD7btfdjw5uxyAccdT09d4hcw5hkCKXHQ@mail.gmail.com>
Subject: Re: [PATCH v8] hv/hv_kvp_daemon:Support for keyfile based connection profile
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Michael Kelley <mikelley@microsoft.com>, Olaf Hering <olaf@aepfle.de>, 
	Shradha Gupta <shradhagupta@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 3:06=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
>
>
>
> > On 09-Oct-2023, at 4:08 PM, Shradha Gupta <shradhagupta@linux.microsoft=
.com> wrote:
> >
> > Ifcfg config file support in NetworkManger is deprecated. This patch
> > provides support for the new keyfile config format for connection
> > profiles in NetworkManager. The patch modifies the hv_kvp_daemon code
> > to generate the new network configuration in keyfile
> > format(.ini-style format) along with a ifcfg format configuration.
> > The ifcfg format configuration is also retained to support easy
> > backward compatibility for distro vendors. These configurations are
> > stored in temp files which are further translated using the
> > hv_set_ifconfig.sh script. This script is implemented by individual
> > distros based on the network management commands supported.
> > For example, RHEL's implementation could be found here:
> > https://gitlab.com/redhat/centos-stream/src/hyperv-daemons/-/blob/c9s/h=
v_set_ifconfig.sh
> > Debian's implementation could be found here:
> > https://github.com/endlessm/linux/blob/master/debian/cloud-tools/hv_set=
_ifconfig
> >
> > The next part of this support is to let the Distro vendors consume
> > these modified implementations to the new configuration format.
> >
> > Tested-on: Rhel9(Hyper-V, Azure)(nm and ifcfg files verified)
>
> Was this patch tested with ipv6? We are seeing a mix of ipv6 and ipv4 add=
resses in ipv6 section:

There is also another issue which is kind of a design problem that
existed from the get go but now is exposed since keyfile support was
added.
Imagine we configure both ipv6 and ipv4 and some interfaces have ipv4
addresses and some have ipv6.
getifaddres() call in kvp_get_ip_info() will return a linked list per
interface. The code sets ip_buffer->addr_family based on the address
family of the address set for the interface. We use this to determine
which section in the keyfile to use, ipv6 or ipv4. However, once we
make this decision, we are locked in. The issue here is that
kvp_process_ip_address() that extracts the IP addresses concatenate
the addresses in a single buffer separating the IPs with ";". Thus
across interfaces, the buffer can contain both ipv4 and ipv6 addresses
separated by ";" if both v4 and v6 are configured. This is problematic
as the addr_family can be either ipv4 or ipv6 but not both.
Essentially, we can have a situation that for a single addr_family in
hv_kvp_ipaddr_value struct, the ip_addr member can be a buffer
containing both ipv6 and ipv4 addresses. Notice that
process_ip_string() handles this by iterating through the string and
for each ip extracted, it individually determines if the IP is a v6 or
a v4 and adds "IPV6ADDR" or "IPADDR" to the ifcfg file accordingly.
process_ip_string_nm() does not do that and solely makes the
determination based on is_ipv6 values which is based on a single
addr_family value above. Thus, it cannot possibly know whether the
specific IP address extracted from the string is a v4 or v6. Unlike
for ifcfg files, fir nm keyfiles, we need to add v4 and v6 addresses
in specific sections and we cannot mix the two. So we need to make two
passes. One for v4 and one for v6 and then add IPs in the respective
sections.

This issue needs to be looked into and unless it's resolved, we cannot
support both ipv4 and ipv6 addresses at the same time.

Thoughts?


