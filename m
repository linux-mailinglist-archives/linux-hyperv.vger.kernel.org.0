Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5324D2B1ABB
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Nov 2020 13:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgKMMFC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Nov 2020 07:05:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34105 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgKMLca (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Nov 2020 06:32:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id r17so9447903wrw.1;
        Fri, 13 Nov 2020 03:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NDe2ONkXQ2sInU12eibxw5UguccRghPGCP7Yu0BHDUI=;
        b=KtKGDXQEYS9DY/tjLuMNHqIFT1yRJwlp4B4MjRjVe5Qg8WZ0OKRvkE/H9KWtj4jx7V
         d7YU2CCcv9A7PIj4JOwTPz3OQJguNkgM4mG47qDMVNKT42a29Jxk3Hy7mLORZ3IoGdwv
         JNBnDF/57P0CkqNhoKcTrdltVy7UP/wLleUBtCtzjFkbLqepwlJUL2vcia/rYlgQNFVw
         wajoMHTvtwpzGCnNjZLZIVIbYrcqOsiXBsKAq8Ez5dot9cNY+teg2zwor+lyeCgr8TSG
         bg2DZGc/u/WUZhGHytj9qq0rFWAcAnfYSZEnBdiNR+38QtZO4uM20Rb+S/rLNT2vA33y
         evqQ==
X-Gm-Message-State: AOAM531Qv7p7XVNmOLDwD/MN/veh9wwhrngCP11VT/BnL+KXBic78idq
        IDO44Zp8zDwmWR4mJ1EtBEs=
X-Google-Smtp-Source: ABdhPJx3lEAxC/EGojmlJAySUAJNOhqu5M2CGXLnLqmr0mGJkFmfF2QuqpKLlgP06GfXletRG6e38A==
X-Received: by 2002:a5d:6cc5:: with SMTP id c5mr3029836wrc.301.1605267148490;
        Fri, 13 Nov 2020 03:32:28 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n11sm10445889wru.38.2020.11.13.03.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 03:32:27 -0800 (PST)
Date:   Fri, 13 Nov 2020 11:32:26 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Andres Beltran <lkmlabelt@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>
Subject: Re: [PATCH v9 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Message-ID: <20201113113226.chmgg6hhfamomz5p@liuwe-devbox-debian-v2>
References: <20201109100402.8946-1-parri.andrea@gmail.com>
 <20201109100402.8946-2-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109100402.8946-2-parri.andrea@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Nov 09, 2020 at 11:04:00AM +0100, Andrea Parri (Microsoft) wrote:
> From: Andres Beltran <lkmlabelt@gmail.com>
> 
> Currently, VMbus drivers use pointers into guest memory as request IDs
> for interactions with Hyper-V. To be more robust in the face of errors
> or malicious behavior from a compromised Hyper-V, avoid exposing
> guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
> bad request ID that is then treated as the address of a guest data
> structure with no validation. Instead, encapsulate these memory
> addresses and provide small integers as request IDs.
> 
> Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> Co-developed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Wei Liu <wl@xen.org>
