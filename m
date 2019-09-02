Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B76A5954
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2019 16:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfIBO1R (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 10:27:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50196 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbfIBO1R (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 10:27:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id c10so2911085wmc.0;
        Mon, 02 Sep 2019 07:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8aEmKxykDndXFGiMc09N0+3vyQXksajAhUoOKsW/WK0=;
        b=c69GCzD5saQcdqLrMovQtXGXQEwVW2MJXB4LJN0f6H54qUBjTuHY/oTrgdLt0FjRLF
         tfPeBAg3MhN5q7mKw5K2WZ4PZGfRwtGzqyEvCGvgV+XCJ3d/wJL6UgGo1jdmPVRALGub
         LeC9ZK5XMqL/rlIsKclxKgA1vyyDY139Xkf5My6v1+1DnqGhEubJKeVjWgMQIf7+a9ab
         zuxjBN1+pq4W61t71ndduHV20fsfcu6NFRXAZk0msgtmrGlFBuoOfoNzL6OLRgcS/eF1
         6oAy2PcHFSN8e+K+XzCrqeIP5TYD/GBIFUcdOSxiWIBkHuz2WZKNK8ryAaA/8OMAu+3Q
         n4IQ==
X-Gm-Message-State: APjAAAWFN/H4pikAxCd7KkMXrH1gd//SUa3+MXkHtQqdd6O1ORs3a3UB
        TpH43pbRyJ3rgCCfwWTWdTM=
X-Google-Smtp-Source: APXvYqwyfddA/cMRPecq6/P3O1MlQw7z2N8mx8lHHIajlCGKJ0NFgh6GCVZjhxptGjVO52lBT01q+g==
X-Received: by 2002:a7b:cc0a:: with SMTP id f10mr37660760wmh.6.1567434435563;
        Mon, 02 Sep 2019 07:27:15 -0700 (PDT)
Received: from liuwe-gateway.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.140.50.101])
        by smtp.gmail.com with ESMTPSA id g15sm12937489wmk.17.2019.09.02.07.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 07:27:14 -0700 (PDT)
Date:   Mon, 2 Sep 2019 14:27:13 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     lantianyu1986@gmail.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] x86/Hyper-V: Fix reference of pv_ops with
 CONFIG_PARAVIRT=N
Message-ID: <20190902142713.erskx45n3agnzvlu@liuwe-gateway.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <20190828080747.204419-1-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828080747.204419-1-Tianyu.Lan@microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 28, 2019 at 04:07:47PM +0800, lantianyu1986@gmail.com wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> hv_setup_sched_clock() references pv_ops and this should
> be under CONFIG_PARAVIRT=Y. Fix it.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
