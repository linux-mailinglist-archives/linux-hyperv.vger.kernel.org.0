Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B59DDAC498
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Sep 2019 06:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404331AbfIGE02 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 7 Sep 2019 00:26:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37006 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404301AbfIGE01 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 7 Sep 2019 00:26:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id b10so4144209plr.4
        for <linux-hyperv@vger.kernel.org>; Fri, 06 Sep 2019 21:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=uRpzcGRK0gWOk89qrLh7rcTqBiKXyCtjzVPSfOAgpVU=;
        b=etwCiax2gYdlC4zP7k7KvjURjCrgAs+KXsRggYDRDUSymUUnwC/2d3q8vjQwUWtudw
         OSlZL4GgcgosbLef5+vO8HsQSFba21KpO+8TzzlB/xLI3mkZrv+qC2MyzRbX7/DW00VY
         1qJWdUbMv87N3RbQ7gkM8xgBTX7pTUwAHsH9SqiluIV2b+uU71JYYmisQZF0IK6RZVhl
         jNNaJOoj9OaJUZFwrOJRkY6emDZTA6RBNSIW2IYqQ1G/Si/2hEo5Vdp1YviTIyBQDa/B
         sW9vwo5ucxzgbZynOtDN0nB2u3aQ5+5pT8Ftz7eALy7+EGvelHsKuetu+FVTbcoYlNwu
         IilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=uRpzcGRK0gWOk89qrLh7rcTqBiKXyCtjzVPSfOAgpVU=;
        b=Pe0ObryIEopImdEhX+fk8A/hjVb23uJNVaTZcgtX7msJUvP2ffhVFO77WIKX0Ospcy
         WhdOUk3eKY97yjcO53L/VS5gJPfLWKyVMX7gCIHHYu4sM6lXyrD4qSqMJAMx0uiCM0K0
         TJEZxL8MxnaaA0s+4OxgeHATwh9R9uIhczEWAbK+F7zsVimInZ5GUr6gPRZ1Ho2MPNhZ
         jJP1jDMLxI+rXyZ1pGbIUVhgSYkM8AN2A464wVwdb03Zjrgbo3O57FdnZP3QPCdoxsaa
         D087S29MIuFrH/hBGgZZKCKE5YizYi2Ud66/JPvu3xdMnY5Dt7F6WKnJOvMNJtDbXZBU
         JJ+w==
X-Gm-Message-State: APjAAAXWNpuLMwk1JqVdk91HShbLLLmL1sCPZgyxpueI7Lvp/9lwmVnn
        F4khfpvURJPbDEJSM+ECGZbARg==
X-Google-Smtp-Source: APXvYqxE3DEYli99jbhJRPwsT4eS+AzKygv9JQnFqqCwc5fAJeR+sbz8pQ8zDfV5T+ASAwBuB9DdCA==
X-Received: by 2002:a17:902:b215:: with SMTP id t21mr6431411plr.141.1567830387142;
        Fri, 06 Sep 2019 21:26:27 -0700 (PDT)
Received: from cakuba.netronome.com ([45.41.183.19])
        by smtp.gmail.com with ESMTPSA id z12sm7810845pfj.41.2019.09.06.21.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 21:26:26 -0700 (PDT)
Date:   Fri, 6 Sep 2019 21:25:48 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>
Subject: Re: [PATCH net-next, 2/2] hv_netvsc: Sync offloading features to VF
 NIC
Message-ID: <20190906212548.685b5f83@cakuba.netronome.com>
In-Reply-To: <DM6PR21MB13373166435FD2FC5543D349CABB0@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <1567136656-49288-1-git-send-email-haiyangz@microsoft.com>
        <1567136656-49288-3-git-send-email-haiyangz@microsoft.com>
        <20190830160451.43a61cf9@cakuba.netronome.com>
        <DM6PR21MB13373166435FD2FC5543D349CABB0@DM6PR21MB1337.namprd21.prod.outlook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 5 Sep 2019 23:07:32 +0000, Haiyang Zhang wrote:
> > On Fri, 30 Aug 2019 03:45:38 +0000, Haiyang Zhang wrote:  
> > > VF NIC may go down then come up during host servicing events. This
> > > causes the VF NIC offloading feature settings to roll back to the
> > > defaults. This patch can synchronize features from synthetic NIC to
> > > the VF NIC during ndo_set_features (ethtool -K), and
> > > netvsc_register_vf when VF comes back after host events.
> > >
> > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > Cc: Mark Bloch <markb@mellanox.com>  
> > 
> > If we want to make this change in behaviour we should change net_failover
> > at the same time.  
> 
> After checking the net_failover, I found it's for virtio based SRIOV, and very 
> different from what we did for Hyper-V based SRIOV.
> 
> We let the netvsc driver acts as both the synthetic (PV) driver and the transparent 
> bonding master for the VF NIC. But net_failover acts as a master device on top 
> of both virtio PV NIC, and VF NIC. And the net_failover doesn't implemented 
> operations, like ndo_set_features.
> So the code change for our netvsc driver cannot be applied to net_failover driver.
> 
> I will re-submit my two patches (fixing the extra tab in the 1st one as you pointed 
> out). Thanks!

I think it stands to reason that two modules which implement the same
functionality behave the same.
