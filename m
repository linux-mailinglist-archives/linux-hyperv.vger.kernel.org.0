Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7592BB78EB
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2019 14:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbfISMK7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-hyperv@lfdr.de>); Thu, 19 Sep 2019 08:10:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36454 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388551AbfISMK7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Sep 2019 08:10:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id y189so3097767qkc.3;
        Thu, 19 Sep 2019 05:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rfjil+Gq/luy5INXzAP+YSY4vFtchBGrxw5c+694d1c=;
        b=ceVXQyGNSLMr5yEULRJK+2srb0yNaT7KzQEhFO1XymeRmKLgB0+G7sghWVKF3CXI6a
         OWSLh/3+sZkCwGZc6THoIpNJUAX8GKf1xvwIbClzNk78GkKpTsIdZ1U7N8WK4VDYC2ta
         DB8XumBx+zY4plY+0JRXHYGRBiNq/bB3CpkMIZq0Xb5gZuaALqGeq843jltvL/6Cqbxj
         AQin3b2FpvUhvILIuMooQNvCG6yznhAUt1+VAEO8z8y934w+gynnPF1qXOcfthQkH/KP
         sHhJuhqTy0FN+qxN3XZVwKUYxhRFXGXHirAYbeGxR0L7iROrSJ90zYVkoKTjAhPLGIDp
         Cc2w==
X-Gm-Message-State: APjAAAWw+I4sPIe8Jhzp8oZ1PpQ3tR9JvhNRuf183lfxfSmRY+2zUmFl
        Zxu5SZJnX0fQYjG6oys2kbhl66eu+gDwJ4AstK8=
X-Google-Smtp-Source: APXvYqzEGMHFOqeRV6vBVoW42UtFIGlWnJ0ZoY4L2i95kgRTZeHSNklf6BqNgTS+9n5WCxLwwc4EU4ayKlB0xLq+U2M=
X-Received: by 2002:ae9:c110:: with SMTP id z16mr2567279qki.352.1568895058438;
 Thu, 19 Sep 2019 05:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <1568870297-108679-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1568870297-108679-1-git-send-email-decui@microsoft.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Sep 2019 14:10:42 +0200
Message-ID: <CAK8P3a0oi2MQwt-P8taBt+VS+RTaoeNBgjoYNE7_L2VoQUSaEA@mail.gmail.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix harmless building warnings
 without CONFIG_PM
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 19, 2019 at 7:19 AM Dexuan Cui <decui@microsoft.com> wrote:
>
> If CONFIG_PM is not set, we can comment out these functions to avoid the
> below warnings:
>
> drivers/hv/vmbus_drv.c:2208:12: warning: ‘vmbus_bus_resume’ defined but not used [-Wunused-function]
> drivers/hv/vmbus_drv.c:2128:12: warning: ‘vmbus_bus_suspend’ defined but not used [-Wunused-function]
> drivers/hv/vmbus_drv.c:937:12: warning: ‘vmbus_resume’ defined but not used [-Wunused-function]
> drivers/hv/vmbus_drv.c:918:12: warning: ‘vmbus_suspend’ defined but not used [-Wunused-function]
>
> Fixes: 271b2224d42f ("Drivers: hv: vmbus: Implement suspend/resume for VSC drivers for hibernation")
> Fixes: f53335e3289f ("Drivers: hv: vmbus: Suspend/resume the vmbus itself for hibernation")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

I think this will still produce a warning if CONFIG_PM is set but
CONFIG_PM_SLEEP is not, possibly in other configurations as
well.

      Arnd
