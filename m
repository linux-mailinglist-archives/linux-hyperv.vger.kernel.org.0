Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D1932C6A9
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Mar 2021 02:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhCDA3t (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Mar 2021 19:29:49 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:38193 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbhCCLym (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Mar 2021 06:54:42 -0500
Received: by mail-wm1-f52.google.com with SMTP id n4so6055441wmq.3;
        Wed, 03 Mar 2021 03:52:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MgKg+xuFshcWxF/EWFStdvX3IMRA6xhZUH5DmSOHrFs=;
        b=LjYoeZszioumhHvJDQgEbvUa5XEuiXcFh3xWVbvdJYNJJ0IIzgiAWw+yyspiPOu2og
         dVxg5n3l1NibcPGRh1Ti7/yNHlHWMU3igPbnA5Or1y0H3ffYhboCfehYYpDqr5YCJfyO
         zCEmOrF1dtJ2bSxP50hc1r1pLACPWPqJiWErBIM1ao45Mkm4d1VI7MHL2vkROVmU95p2
         2aPK8QkDgSp9wsPlq7fiowk/lXeuklk8sx0LFNlyrDxTAFPvwfq3BxlfW80T+aa6Q+oG
         eCnf6QUgttVbVQaHE5ao8G1lSgCIM0+YwAO3lZME3H/lBO6YMVkKYrhdr5g79YFjqo9z
         7cFA==
X-Gm-Message-State: AOAM5325lNhiB4SGX1kpkSs4Rj9nvY2DmuDviitIwBJrJRRdFRyib+1s
        deiDptR16VM1HRZbV+iMECs=
X-Google-Smtp-Source: ABdhPJwbVQqhAFsa13auW4eF3yjMx+StH3dqVQPam9+Jh5V2R/AUGy6jdsUSjFw678Ny0MVLZodEFA==
X-Received: by 2002:a7b:cb90:: with SMTP id m16mr8770689wmi.162.1614772335253;
        Wed, 03 Mar 2021 03:52:15 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a75sm5914399wme.10.2021.03.03.03.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 03:52:14 -0800 (PST)
Date:   Wed, 3 Mar 2021 11:52:13 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH] Drivers: hv: vmbus: Drop error message when 'No request
 id available'
Message-ID: <20210303115213.h355ncqtezsigjxz@liuwe-devbox-debian-v2>
References: <20210301191348.196485-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301191348.196485-1-parri.andrea@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 01, 2021 at 08:13:48PM +0100, Andrea Parri (Microsoft) wrote:
> Running out of request IDs on a channel essentially produces the same
> effect as running out of space in the ring buffer, in that -EAGAIN is
> returned.  The error message in hv_ringbuffer_write() should either be
> dropped (since we don't output a message when the ring buffer is full)
> or be made conditional/debug-only.
> 
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Fixes: e8b7db38449ac ("Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus hardening")

Applied to hyperv-fixes.

Wei.
