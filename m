Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5645F36477F
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Apr 2021 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbhDSPy2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Apr 2021 11:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbhDSPy1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Apr 2021 11:54:27 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20AFC061761
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Apr 2021 08:53:57 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id p12so24546885pgj.10
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Apr 2021 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgBc8DK/uiwWd9qSl4rojF6ng4YEQX2bdE7yvqzTNqE=;
        b=u/oVPFKGt9zHYgML5cUAw/Efd89FKRDWGw/I98AIsuX396f+7JRPeCnIUHAHru1YT2
         alg0X3wpoibmMgW+2MNttK/aM4Yl0f6ZYHI83pH39evE9PkcaLic9Fl6xyDZ1RiztV5D
         cb4hY/XzhuJsBWMqFuBXSTkNEEtW0pM9mhrSFYVQ7iKgpmUQAIb/jV9RoQmwn+I2SCaD
         XJylUweHVGOHHg5kiBEaLn2cNFptE/QUjaZuGr3UOFslqFjPbhtXVQ1kj8KbjbRR6hwB
         38JVZeVYq3g9co/SPSJGM5/9scP6o6h0q29gecdtZ+eUupOg8yqaxzt7Dw2/BW06JFYw
         qKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgBc8DK/uiwWd9qSl4rojF6ng4YEQX2bdE7yvqzTNqE=;
        b=ji3K0z5PHX6cvVVWX5CtDw+q0r9BHkfWkhO6lFP3yDXTnNKu4k6sdVhG0vHQZWF5Gx
         Lxth2fk40kRg8vDjS8qNF3HKRueMCw8ZyunxG7lDfuoTAmBIXfYS76LX9XVIThRI4KVc
         Zg8B3jk0wQnKi1mMOrLZPg7WkcKsGGXyozLzfAaL/o7F1zCXab0NR0KuGMI92nfIjnqS
         WJ1Hn+XC/tKwfj7WWiYbThs/Yjsw+HpkmNH4dr2jrsWyd0G6+pS3TI/rGLalm7Odp4fb
         c7QcNifrAyVlTB6hSGTVm7sK9InjzKQp4ADxqTn99/eJLTiy9tazAdnYxQsFmxaS81xa
         RihQ==
X-Gm-Message-State: AOAM531x5YnTyjuE9HMWMADtWxEor3/+KffOnKngW+Mn0ne8Ap9ypUCl
        faBV7Vhgsw4ukgeHrLORUgswyg==
X-Google-Smtp-Source: ABdhPJxxPK27y5npo1SqwJ7a8gTGdvn/PllAqMSn62dXKMIn47wfM5wDjZYvXwAXdTmnsdwC5cinmg==
X-Received: by 2002:a63:145a:: with SMTP id 26mr12295651pgu.300.1618847637567;
        Mon, 19 Apr 2021 08:53:57 -0700 (PDT)
Received: from hermes.local (76-14-218-44.or.wavecable.com. [76.14.218.44])
        by smtp.gmail.com with ESMTPSA id m7sm1704803pfc.218.2021.04.19.08.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:53:57 -0700 (PDT)
Date:   Mon, 19 Apr 2021 08:53:48 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     davem@davemloft.net, kuba@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        liuwe@microsoft.com, netdev@vger.kernel.org, leon@kernel.org,
        andrew@lunn.ch, bernd@petrovitsch.priv.at, rdunlap@infradead.org,
        shacharr@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v8 net-next 1/2] hv_netvsc: Make netvsc/VF binding check
 both MAC and serial number
Message-ID: <20210419085348.6f5afd0b@hermes.local>
In-Reply-To: <20210416201159.25807-2-decui@microsoft.com>
References: <20210416201159.25807-1-decui@microsoft.com>
        <20210416201159.25807-2-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 16 Apr 2021 13:11:58 -0700
Dexuan Cui <decui@microsoft.com> wrote:

> Currently the netvsc/VF binding logic only checks the PCI serial number.
> 
> The upcoming Microsoft Azure Network Adapter (MANA) supports multiple
> net_device interfaces (each such interface is called a "vPort", and has
> its unique MAC address) which are backed by the same VF PCI device, so
> the binding logic should check both the MAC address and the PCI serial
> number.
> 
> The change should not break any other existing VF drivers, because
> Hyper-V NIC SR-IOV implementation requires the netvsc network
> interface and the VF network interface have the same MAC address.
> 
> Co-developed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Co-developed-by: Shachar Raindel <shacharr@microsoft.com>
> Signed-off-by: Shachar Raindel <shacharr@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
