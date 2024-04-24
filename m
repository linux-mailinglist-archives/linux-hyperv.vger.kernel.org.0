Return-Path: <linux-hyperv+bounces-2042-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D068B0D16
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Apr 2024 16:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DE71F26434
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Apr 2024 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB9315D5AF;
	Wed, 24 Apr 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ogoM/PS1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AE515E5BE
	for <linux-hyperv@vger.kernel.org>; Wed, 24 Apr 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970094; cv=none; b=HdZhZJYJ80NdU8906W9wNGTFQ5DW9WhbXSeHE1Bxa3JdPjK87ru0mecMX9vfs/1CDQ7ovVvvKeeHhygD/iIa//rckQFlwIsuTAcB8bN3Z6AT4PJYeaYn77SBUJ3ENIvpcFd1UDUXv5ZBt4M6BJ8XaY3xrKev39w/F4XdK9Pu0vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970094; c=relaxed/simple;
	bh=pZRMHeRrZ7PqTOAeDPMoXssbpZwAoT0QUjHK0yTI7G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcCNpSOZcUjJ2cn4ikL4+I2V2dE2jCKHrfa9a1o7wQR0VxRqB0a4mKXMbSItM6Wna08aIqfRV+l47LtkoGhvrn+8IGfgFpRm7Kh9MIxceTipfKE8k0IaVh8/3XcmbLcviWT4srnJlgoKbgSMTz/KFbhckQHsD8qVCsFp7m2MSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ogoM/PS1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso193111566b.1
        for <linux-hyperv@vger.kernel.org>; Wed, 24 Apr 2024 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713970091; x=1714574891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVbaUyrmVafdj/cQpZaiAaBbKWO3w1dBZ7Hp+YT/Oh8=;
        b=ogoM/PS1Y2jX+13pwUTQ0rudu54Dmu2iJ7RNx2vmuACcmsFTVv6vIHNhtekmDb3nCu
         8BusBlotgIy49+T7uufsI7jkabpyw6Qgn0OOe9xrsHCF8b+/WiXRavurqvkpYDqGlY2W
         bMdYlIbaX1V5LzLf1HkChyUNv5S35MFFI6vLVy+LVUycgNK0M1ntygEzSiL9dJFSH+JS
         PjzZbANMK+XkJ3wqPfrrvKAnXwJmWfb3YtDwhpo7cbZnwWpLLczj6prwBaquXsTaPY7J
         Dd9HshcE9GBUZzUwqvwxbq8eaUvX6emjkeYk+v4j1fiYaEu7x2CzW/PgSiDlkVmH2O/W
         J5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970091; x=1714574891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVbaUyrmVafdj/cQpZaiAaBbKWO3w1dBZ7Hp+YT/Oh8=;
        b=arj+nbBXnU91OnKkymJdtOL3drVppQQUSaIxoeXijC0xWR5ypPAXX7g8+Ns5ooOzvI
         5p0e59BOTV+DPaT2ziM3gY4Ck6+OTqL59luv5FT+mz3Z++GgtM3yQUPy03J/E0D3rZEn
         7aciFho5OebLQ7mv3qPqd+o0Z61pkEU+na8UtRuDQRkB3dMiNDwG6xppkF7yTs5u/vJb
         pNx7sjnwwU7YaJ4foH++kTSo130ynqxpRPr+2pddJjRXH/Kag28o7hcPahXVJ3Rt8CHB
         /rIpHgLElKtYEl7i5Dhd2UA5slir1BACOPaEJZrw0btOZuGiOyxxU3DYL2wYD1pyxFqm
         xYRg==
X-Forwarded-Encrypted: i=1; AJvYcCXeir+fHGWq6jQAOBvQZiEZgTNQatjZ4GjxHYZAyz1QamHUiVWM+UiI6YQL7Td3pP99Hh8FAz7ajrAV3qF18hBnx03dnRfghfmN9BhX
X-Gm-Message-State: AOJu0YzqGBUtu8kkPtTLwk7baocQ9xg0/OBFTppjdBE6TCiN8NNZNyB/
	Ra3U6nnQvKptOdhwGdLCy5vt0RcRrlHKY8XhBjzcJuYet41rVL7fYiLqy9v8XwQ=
X-Google-Smtp-Source: AGHT+IHyL7UR+GGslunB2Saa9OzbsgaAEz0dYE5qzWUKj2z2emKP9Bh5u/mfXv0ND1AFRSdoAqJmPw==
X-Received: by 2002:a17:906:5650:b0:a52:6e87:77ef with SMTP id v16-20020a170906565000b00a526e8777efmr6378733ejr.6.1713970091244;
        Wed, 24 Apr 2024 07:48:11 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id q21-20020a170906771500b00a51d408d446sm8438326ejm.26.2024.04.24.07.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:48:10 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:48:06 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>, linux-hyperv@vger.kernel.org,
	shradhagupta@microsoft.com
Subject: Re: [PATCH net-next v2 0/2] Add sysfs attributes for MANA
Message-ID: <ZikbpoXWmcQrBP3V@nanopsycho>
References: <1713954774-29953-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713954774-29953-1-git-send-email-shradhagupta@linux.microsoft.com>

Wed, Apr 24, 2024 at 12:32:54PM CEST, shradhagupta@linux.microsoft.com wrote:
>These patches include adding sysfs attributes for improving
>debuggability on MANA devices.
>
>The first patch consists on max_mtu, min_mtu attributes that are
>implemented generically for all devices
>
>The second patch has mana specific attributes max_num_msix and num_ports

1) you implement only max, min is never implemented, no point
introducing it.
2) having driver implement sysfs entry feels *very wrong*, don't do that
3) why DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX
   and DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN
   Are not what you want?

>
>Shradha Gupta (2):
>  net: Add sysfs atttributes for max_mtu min_mtu
>  net: mana: Add new device attributes for mana
>
> Documentation/ABI/testing/sysfs-class-net     | 16 ++++++++++
> .../net/ethernet/microsoft/mana/gdma_main.c   | 32 +++++++++++++++++++
> net/core/net-sysfs.c                          |  4 +++
> 3 files changed, 52 insertions(+)
>
>-- 
>2.34.1
>
>

