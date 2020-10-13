Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF9728CB1B
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Oct 2020 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgJMJkW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Oct 2020 05:40:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52143 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbgJMJkV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Oct 2020 05:40:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id d81so20273021wmc.1;
        Tue, 13 Oct 2020 02:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EvJccBIddvEHIHsjjwupgOo/uloSTmqFagIntZxnq3A=;
        b=bbOolcI/OYtDAoI6t1la2zqsk19FLGtkSjS0OVfEQ4lTEJI3av1eqidJIdAMa1hkSg
         T80gUVyiXhN5POZRzuoCOOQLv9G0F8H+5FHaRvUWAlX5vH3IrhFIbRGFaQcBICBDVgNL
         TyFap1YIfTRS6gRoj6cMU7DO9uXodAN0EA1khQrn/DJROIJ/BID+Fs7MkDoCbZQ2nxRa
         fAOJNOYRxFXbYKnRpJudMorSy/1wSH7HpowFlIlo4dME6r2K1ixmllXZEY/OVGrvdVTw
         LXNwL/14mmsLqxgdttPiYxPkHDITFil8iwmyc4Iyz0O1jRieF8r9bUU9hQwBGheVULaQ
         Z7BA==
X-Gm-Message-State: AOAM533EVFuFwh5H0uImSdhHCgcMnb2tXYAIlSbkdiojCa43keI29q2l
        dREsSoH/JwwG+HaIQwfDh9M=
X-Google-Smtp-Source: ABdhPJwW9hPHOQVIdE+yNl6GLXf929nUvcDA+0kXSS17AgTpgnB8j989HmOO91aKkGQpXnZvOpIGHg==
X-Received: by 2002:a1c:960a:: with SMTP id y10mr14432345wmd.128.1602582019887;
        Tue, 13 Oct 2020 02:40:19 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u12sm29091026wrt.81.2020.10.13.02.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 02:40:19 -0700 (PDT)
Date:   Tue, 13 Oct 2020 09:40:17 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v1] hv_balloon: disable warning when floor reached
Message-ID: <20201013094017.brwjdzoo2nxsaon5@liuwe-devbox-debian-v2>
References: <20201008071216.16554-1-olaf@aepfle.de>
 <20201008091539.060c79c3.olaf@aepfle.de>
 <20201013091717.q24ypswqgmednofr@liuwe-devbox-debian-v2>
 <20201013111921.2fa4608c.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013111921.2fa4608c.olaf@aepfle.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Oct 13, 2020 at 11:19:21AM +0200, Olaf Hering wrote:
> Am Tue, 13 Oct 2020 09:17:17 +0000
> schrieb Wei Liu <wei.liu@kernel.org>:
> 
> > So ... this patch is not needed anymore?
> 
> Why? A message is generated every 5 minutes. Unclear why this remained
> unnoticed since at least v5.3. I have added debug to my distro kernel
> to see what the involved variable values are. More info later today.

What I mean is you seem to have found a way to configure the system to
get what you want it to do. It was unclear to me whether this patch is
absolutely necessary from your last reply.

Some may consider the log informational (like you), some may think it
warrants a warning (because not enough memory).  People also don't seem
to be particularly bother by it since its introduction in 4.10.

I have no objection to applying this patch. I can pick it up if I don't
hear objection in the next couple of days.

Wei.

> 
> Olaf


