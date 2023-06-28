Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9767B741789
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jun 2023 19:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjF1Rxu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Jun 2023 13:53:50 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:50201 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjF1Rxp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Jun 2023 13:53:45 -0400
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-54f87d5f1abso3318351a12.0;
        Wed, 28 Jun 2023 10:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687974825; x=1690566825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rH1w84gNN5G82KmJfuI+u4t8267PkH4gL6EwCL5odH0=;
        b=Y8q4wV4YUKMvK81wf7fF8gtd55XkLLvUG0MQewRfaIz5Iuoj0b66cBQ6MQXB+z7MmE
         ZYbA8+21TJu9GzctAQ7GnfPNhOQ0fnhRqw6rUMTFhyiGpfIw+Ebe1GDZhybny67E3VS2
         h+1PY+xzIO5JPqpiaEEeZrrNov+luspuFnk+hmW3ZBeRsqR8JBUFTZeAk2VqbQzTUbrJ
         e5sYEWRX+4cTI5wdfFgIb3oNp0bklLCNMFNgRyQIbaCMrn3jJhtOxwOAI732Ld7BBIc5
         aNx+H2QReoTRswe2sSECSboq9O7EecS+L946Qu4xdlRxHVgeaY/p4qheW9OlHVgcUQrN
         vr6Q==
X-Gm-Message-State: ABy/qLYWL6QbSTYLokzkE2gXFXNpr1U9b0q8EjWhMRb5wzR5W2a98KIi
        nfPV9akdRsgqadCeiYe2XfQ=
X-Google-Smtp-Source: APBJJlGSpOxxN0oABYwCbwzJyxX1X07vCkqIADsm0ecgnirgEZjCp9N07TG2rFZG4wTDAMsabsyq2g==
X-Received: by 2002:a17:90a:13cd:b0:263:5333:56a8 with SMTP id s13-20020a17090a13cd00b00263533356a8mr427479pjf.21.1687974825376;
        Wed, 28 Jun 2023 10:53:45 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id co21-20020a17090afe9500b00262dbf8648esm6848805pjb.34.2023.06.28.10.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 10:53:44 -0700 (PDT)
Date:   Wed, 28 Jun 2023 17:53:43 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nischala Yelchuri <niyelchu@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, K.Y.Srinivasan@linux.microsoft.com,
        kys@microsoft.com, Haiyang@linux.microsoft.com,
        Zhang@linux.microsoft.com, haiyangz@microsoft.com,
        Wei@linux.microsoft.com, Liu@linux.microsoft.com,
        wei.liu@kernel.org, Dexuan@linux.microsoft.com,
        Cui@linux.microsoft.com, decui@microsoft.com,
        Thomas@linux.microsoft.com, Gleixner@linux.microsoft.com,
        tglx@linutronix.de, Ingo@linux.microsoft.com,
        Molnar@linux.microsoft.com, mingo@redhat.com,
        Borislav@linux.microsoft.com, Petkov@linux.microsoft.com,
        bp@alien8.de, Dave@linux.microsoft.com, Hansen@linux.microsoft.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        H.PeterAnvin@linux.microsoft.com, hpa@zytor.com,
        Tyler@linux.microsoft.com, Hicks@linux.microsoft.com,
        code@tyhicks.com, niyelchu@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Improve code for referencing
 hyperv_pcpu_input_arg
Message-ID: <ZJxzp7zJVTIFAylj@liuwe-devbox-debian-v2>
References: <1687286438-9421-1-git-send-email-niyelchu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687286438-9421-1-git-send-email-niyelchu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 20, 2023 at 11:40:38AM -0700, Nischala Yelchuri wrote:
> Several places in code for Hyper-V reference the
> per-CPU variable hyperv_pcpu_input_arg. Older code uses a multi-line
> sequence to reference the variable, and usually includes a cast.
> Newer code does a much simpler direct assignment. The latter is
> preferable as the complexity of the older code is unnecessary.
> 
> Update older code to use the simpler direct assignment.
> 
> Signed-off-by: Nischala Yelchuri <niyelchu@linux.microsoft.com>

Applied to hyperv-fixes. Thanks!
