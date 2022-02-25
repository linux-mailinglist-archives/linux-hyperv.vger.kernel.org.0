Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5F54C3D89
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Feb 2022 06:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiBYFNg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Feb 2022 00:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiBYFNg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Feb 2022 00:13:36 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C2D24FA19;
        Thu, 24 Feb 2022 21:13:04 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s1so5781725edd.13;
        Thu, 24 Feb 2022 21:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pr+1wa7r6Cu+77kmww+sAcEtTihXHd1sursZHmObyUM=;
        b=p1/Is8w1KKsLRZDX173/++vNWy8gedj2vpZeH4VQ+VcJQGrsuHKJsbEB0eruRqSvH5
         FnA9WUqxqO8wVlz7DwxP6o+VrdgM3mZOCWhs0HuCcABRBpib3psdZE8rhxJo9eJY88EI
         qcLJ6ApWf8bXOZTIXpsvye+p39vxMgVEII++k28FbSNGWt/2q73T0uJgaFm+8rOiuXrs
         s8n6Lb4ryU2ltzqVwTpUV5WIXnYIqknEcUsnPXWJKWGkJMe7HmPn3YrUadU6wjA2n38z
         rC3f7Tul35I17gaS6++KGJSUI8A/iMo+3FKL+QXSDx3q05GQrC7UtS2716yham9kjDuG
         d2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pr+1wa7r6Cu+77kmww+sAcEtTihXHd1sursZHmObyUM=;
        b=aQFmeVEuM/9Ly2CmYxwz7HC2jA25deBKjMuvCzaE8PzDcqO+p/RSmhUOIfptzW0syq
         ZcLQJpLygkpXKZRHI29jCAWC40ih+D3O+yzLBB+Jx7/S6VnGVA5xsiBtcfHCp+N88dLH
         hxzmiFhgG4kNGjXzI90wgl3RbWYsRvy051c+oiU+dJTNOJewnKrjrq1sUT7wBjYuEXv7
         53+4gu38yQT6LNwZ6LLGMFYGYfUix/D+j1GYu3m4mcwai32fEqXF67kT+ztE5CkZO5TM
         7KA2ig/AVRvYdJqiu7zsM6QAc3fkwciJLhXzZp2YsJowiEteFmeByv/VoNrNRLeMfo4r
         UyAg==
X-Gm-Message-State: AOAM533yTok4GlGEhvzE557FMELBegcO3Sp34fXGMCJSNkRI6uVFnQot
        7JS3hNg5T7R16aMt5qDaFOE=
X-Google-Smtp-Source: ABdhPJwiNAuEMP23YJBZz+m8W82p1Q3KyKj9oR8SOwgO5GKWskUpP6OY5OhrR/TIQZEdcIWTixQuJQ==
X-Received: by 2002:aa7:d499:0:b0:409:4e74:92c6 with SMTP id b25-20020aa7d499000000b004094e7492c6mr5522771edr.124.1645765982943;
        Thu, 24 Feb 2022 21:13:02 -0800 (PST)
Received: from anparri (host-82-51-95-213.retail.telecomitalia.it. [82.51.95.213])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906538b00b006ae38eb0561sm540773ejo.195.2022.02.24.21.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 21:13:02 -0800 (PST)
Date:   Fri, 25 Feb 2022 06:12:54 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, brijesh.singh@amd.com,
        michael.roth@amd.com, jroedel@suse.de, Tianyu.Lan@microsoft.com,
        thomas.lendacky@amd.com, michael.h.kelley@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC FATCH] x86/Hyper-V: Add SEV negotiate protocol support in
 Isolation VM.
Message-ID: <20220225051254.GA4017@anparri>
References: <20220207160928.111718-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207160928.111718-1-ltykernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Nits:

> Hyper-V Isolation VM code uses sev_es_ghcb_hv_call() to read/write MSR
> via ghcb page. The SEV-ES guest should call the sev_es_negotiate_protocol()

ghcb page -> GHCB page

call the sev_es_negotiate_protocol() -> call sev_es_negotiate_protocol()
	(or -- call the sev_es_negotiate_protocol() function)

> to negotiate the GHCB protocol version before establishing the GHCB. Call
> sev_es_negotiate_protocol() in the hyperv_init_ghcb().

in the hyperv_init_ghcb() -> in hyperv_init_ghcb()

(similarly elsewhere).

  Andrea
