Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 208B710817B
	for <lists+linux-hyperv@lfdr.de>; Sun, 24 Nov 2019 03:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKXCoT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 23 Nov 2019 21:44:19 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37446 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKXCoT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 23 Nov 2019 21:44:19 -0500
Received: by mail-pj1-f67.google.com with SMTP id bb19so1306292pjb.4
        for <linux-hyperv@vger.kernel.org>; Sat, 23 Nov 2019 18:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=uSbEr+vhnRVppHeZqO76/gkPHgaCCiq0/m4Ia9qLGuM=;
        b=FwdFgM4aWBOE61JY1zLzibGzXN+gX+CqAjxfTq9aeaW5PrH+QPslmXMFJKbd87qpFk
         D7JNVtl4GVidu26ZYnJqUbhNbm9Dd4NkWJSetB9Nbk6Z+wyWeFq9YF3OlLzdiqARum+U
         yEKWuRfuXQVfBwriu1eqU1kxSPHV8ePvWcYAeNuueS/4oJblmWlc0y2K5qPf8VskDH/u
         tcpZcS99bfJabnMo45/YjLEVaqHQm+o8j51EWE/k9Op+7iU9yZ+KykLnfMevOs6iLubr
         owluzqwZfe77rRmm1pmc+Zr8YtGwMquw2rT7Q6awnV3YKPhQMOzzvpof5tTeXsfCAS8X
         B1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=uSbEr+vhnRVppHeZqO76/gkPHgaCCiq0/m4Ia9qLGuM=;
        b=X0QfkOKzLmGC5k9wlFZzgYdxHKQA5stbuRUQG5MTvhfC0/2lwVNuyp/oBwTm3AqOwT
         qHW1FEjmu6BGnDSRE1OQ0pX5cVj8XBNla847LQnL/4UHvuFrhA8OskAVVlibxIFxOLBq
         V+nEr/rcJe2O8v4gKGN/sTWce75tDXzy2/cHPn3Xtxx98I9hDLAX955CKViggXhcv2pU
         CzReAUOVPpf9YhSsTRnFl0lPbsdpIxTMnHzB5+JljPOnNcss/MeofbfBzlzh7Aorzie8
         4agSm4ASThasqzZCHdY7SXue7yTJv62314k1OPYJkMP2e0ywfl0mKejZaMt9tq8d5D3T
         09jg==
X-Gm-Message-State: APjAAAW1jMvgS7/1HhBZ3iLBntJttxn0gobJTBoY1BoD8GzfC6DR9N6e
        9thHpX7CamsgQa5KhIiWn5CUwg==
X-Google-Smtp-Source: APXvYqwMfHgA5rV5ZOiOUcicFeeVxfDJ7wYY9KmH6lop7UKE8nWEIWhS1PKfh3F1m0NnPerfgZO34g==
X-Received: by 2002:a17:902:8ec5:: with SMTP id x5mr18613869plo.201.1574563458444;
        Sat, 23 Nov 2019 18:44:18 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id n62sm3249514pjc.6.2019.11.23.18.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 18:44:18 -0800 (PST)
Date:   Sat, 23 Nov 2019 18:44:13 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] hv_netvsc: make recording RSS hash depend on
 feature flag
Message-ID: <20191123184413.3b179db4@cakuba.netronome.com>
In-Reply-To: <1574553017-87877-1-git-send-email-haiyangz@microsoft.com>
References: <1574553017-87877-1-git-send-email-haiyangz@microsoft.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, 23 Nov 2019 15:50:17 -0800, Haiyang Zhang wrote:
> From: Stephen Hemminger <sthemmin@microsoft.com>
> 
> The recording of RSS hash should be controlled by NETIF_F_RXHASH.
> 
> Fixes: 1fac7ca4e63b ("hv_netvsc: record hardware hash in skb")
> Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
> Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Applied, thank you!
