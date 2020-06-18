Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D72F1FF0ED
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 13:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgFRLrf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 07:47:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55874 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgFRLrf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 07:47:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so1500385wmm.5;
        Thu, 18 Jun 2020 04:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cFsUtUBh9aNFVLDZvQX6B8teUAK1O+/w59Gia3tUevI=;
        b=UIavvTuUV3TtIWA7NBTcW8BopGXpR8Ee67G4npmHhCj8q9TWeVtZOGZtuGtMK3Nfim
         u7aL0ZLXJ4i+VJwj118/s2ZfUulM4AeZjTU4YkUZibWbgaFE+dllejMxI53OjUgnYxDb
         ZQ6fP7EMpgOcomO+GYcHXzowtD/6DGgW1ENxK0Ws3OeqW4bBNWuar832Bn6Z3B348Ao6
         Mq4HLAMyzcdqmQrgtG1clY97wPfFjecKS4qSjHyqiszwaB1aTkyaU62Kxlv5YGak0zPm
         J7fQV43+Xx0ju7fUC/++sNeY7uP4zeHRF+azOsDRLGK5G6aJl8usiAK16djNBwQM+hC1
         cmQg==
X-Gm-Message-State: AOAM532uAme8PeXUMUBt4pCgqKXz/HKf8GnNUGg36RH6B6xWrhlGnAMN
        vNBvawzjqFBJLmQYOXCg8+U=
X-Google-Smtp-Source: ABdhPJwS415YB/rJb+NXaXvRVl2d4Aq2pYtG+WgCBUB3ffY8PwvYaxMgTUxFb9zCbuYH2eSiqEaltQ==
X-Received: by 2002:a1c:3b43:: with SMTP id i64mr3792942wma.112.1592480852025;
        Thu, 18 Jun 2020 04:47:32 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u7sm3299615wrm.23.2020.06.18.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 04:47:31 -0700 (PDT)
Date:   Thu, 18 Jun 2020 11:47:29 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dexuan Cui <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-mm@kvack.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 1/3] x86/hyperv: allocate the hypercall page with only
 read and execute bits
Message-ID: <20200618114729.bnut7gbj2j4uhjnc@liuwe-devbox-debian-v2>
References: <20200618064307.32739-1-hch@lst.de>
 <20200618064307.32739-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200618064307.32739-2-hch@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 18, 2020 at 08:43:05AM +0200, Christoph Hellwig wrote:
> Avoid a W^X violation cause by the fact that PAGE_KERNEL_EXEC includes the
> writable bit.
> 
> For this resurrect the removed PAGE_KERNEL_RX definitіon, but as
> PAGE_KERNEL_ROX to match arm64 and powerpc.
> 
> Fixes: 78bb17f76edc ("x86/hyperv: use vmalloc_exec for the hypercall page")
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
