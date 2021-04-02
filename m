Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF023530F6
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Apr 2021 00:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhDBWJX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Apr 2021 18:09:23 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:51768 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBWJU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Apr 2021 18:09:20 -0400
Received: by mail-wm1-f42.google.com with SMTP id p19so3047899wmq.1;
        Fri, 02 Apr 2021 15:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c3vF3s2DjqVTCFoSvVE5phrtixECCxkjGnEGpydHZW8=;
        b=ppJJmyMYHqe9EHW/al/xsYEznRlFSt0kTnp/KaK+gHxvU/cTq7KGYCGFnJ6uS/Te50
         FWjbxwrqT8mOaSFt6zQqsgNDuZkgN+PiET6jHAy7XD2KgxiETWgFEQ8APzdkAvz54KBb
         C6yFiTUfevRHCe7bxLAlC9FllVnIJCRPIaSLc6ockEnTDBt4visJKC5LA2UiU1yxGmNM
         ibHwsj8OqBxWlePr7dqpLnBgy1GPMbAJi+R4V0iFc/NHh1lsIQpwx4pg4jGTo1LZpLm5
         on8BTD1V7wYrJ9YgsheLg8FyFiy8AoBUiXqT51jr1g+VpYyrvexodMVIqZoE4BX73wW3
         8+nA==
X-Gm-Message-State: AOAM533HF9j+DTpwiVjo9HgRBPcxFX1YU3TpP7C1vr3jKVSOWcPJoC5z
        dQE8tvfkUjghsFDEm95Y6QU=
X-Google-Smtp-Source: ABdhPJxSHojcKDzxuaWY7J60V/BWdUbUPKzGaWM/lOxiEKPdflRphsO3pQT/Lw/sbBkZEJKTLHohqA==
X-Received: by 2002:a1c:7fcd:: with SMTP id a196mr14636751wmd.180.1617401358177;
        Fri, 02 Apr 2021 15:09:18 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h62sm16239143wmf.37.2021.04.02.15.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 15:09:17 -0700 (PDT)
Date:   Fri, 2 Apr 2021 22:09:16 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-hyperv@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] x86/hyperv: remove unused including
 <linux/version.h>
Message-ID: <20210402220916.edhxrip5gbkw2vyc@liuwe-devbox-debian-v2>
References: <20210326064942.3263776-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326064942.3263776-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Mar 26, 2021 at 02:49:42PM +0800, Zheng Yongjun wrote:
> Remove including <linux/version.h> that don't need it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yongjun Zheng <zhengyongjun3@huawei.com>

Queued for hyperv-next with tweaks to commit message.  Thanks.

Wei.
