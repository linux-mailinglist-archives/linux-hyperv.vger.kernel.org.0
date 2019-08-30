Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAAEA40C0
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Aug 2019 01:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfH3XFQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Aug 2019 19:05:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40613 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfH3XFP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Aug 2019 19:05:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id h3so3995602pls.7
        for <linux-hyperv@vger.kernel.org>; Fri, 30 Aug 2019 16:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=NI9BDtZfkfrCl+dTZfqEJB4bWNMIfe/Up4Cdd59pL2g=;
        b=ni7eJCNBVuVRlLYnYl2bzjCuTIJPzlxVlk/TLefYHHLlJaJ99uhbajuSFCW/XPipa+
         88fyw05AqcMrAkaMzNX3w04s57ImGDkDpMnAVzWadsFUxcSJVdYZ89Xl7YonchbOXEaD
         PCgVN/r18gqfh33GPPJEYFRZXpR568EKqe3VpFNXH8/1+LFh/khSAvJPmq1OvX+EXc11
         txa2pj+KqMzjtM8hBtBSvFyDJgHGph/S91GzdIgoNntqWC8o6hLFb1aAu1lVmH6PNSbe
         NSBgfEYDyAXL5NxDwJaFjdiLImMSDWj4+Jsjn3anvWPjKg/XlhuH1qHinwqYSs90Rvkg
         IBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NI9BDtZfkfrCl+dTZfqEJB4bWNMIfe/Up4Cdd59pL2g=;
        b=AlavUyB0rpYw2pyb0c/oVD/jNAC/CleGRE+epXL8y76RqqC81oTFvjcSSv6mn7M/va
         n0gMofkJFCr+XgpVWYTVkIgNa0aeYBMS24TTkisRjUX7twLqXL3YQCuQ7sYy1Loi3/qk
         bEHY/j/wswEIBDLlEgeRjD2lCQZeRh2bBJx3gUkZGs7VPl+Zd+AjyH8TzVVTxcQFwhe2
         lvowC6WEGLKeG9/c1SRUpZUAUx0WFQAhP8uAskzPqv0RZqK0ZCPLXdhNlX/DL+mOGjJD
         AbE7fREJF166Jl9+1neBTS3inilzcwC4oM0DQPTGremsStSx4sxrSN6uT1/ngFR41hJe
         aKSw==
X-Gm-Message-State: APjAAAU8xzvPhvO7iv6gcrb8M4rlTpMe+p+k5mOXXoB/IJvK7F2d7NGX
        03Qsl7XpIZrQ5ce0OniidrjI0Q==
X-Google-Smtp-Source: APXvYqzlZrhD2umfyBqhvQCNE0YD3z96OCMV30W6iz0UXOvGDit5ze7lKPsitEvryrSAN2eP6WlPmg==
X-Received: by 2002:a17:902:1107:: with SMTP id d7mr17857245pla.184.1567206315345;
        Fri, 30 Aug 2019 16:05:15 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m145sm7947995pfd.68.2019.08.30.16.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:05:15 -0700 (PDT)
Date:   Fri, 30 Aug 2019 16:04:51 -0700
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
Message-ID: <20190830160451.43a61cf9@cakuba.netronome.com>
In-Reply-To: <1567136656-49288-3-git-send-email-haiyangz@microsoft.com>
References: <1567136656-49288-1-git-send-email-haiyangz@microsoft.com>
        <1567136656-49288-3-git-send-email-haiyangz@microsoft.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 30 Aug 2019 03:45:38 +0000, Haiyang Zhang wrote:
> VF NIC may go down then come up during host servicing events. This
> causes the VF NIC offloading feature settings to roll back to the
> defaults. This patch can synchronize features from synthetic NIC to
> the VF NIC during ndo_set_features (ethtool -K),
> and netvsc_register_vf when VF comes back after host events.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Mark Bloch <markb@mellanox.com>

If we want to make this change in behaviour we should change
net_failover at the same time.
