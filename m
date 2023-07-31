Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253FF76A42D
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Aug 2023 00:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjGaW3M (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Jul 2023 18:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjGaW3I (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Jul 2023 18:29:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3908173E
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Jul 2023 15:29:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-585fb08172bso31623417b3.2
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Jul 2023 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690842546; x=1691447346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q8GvYD+4dtlsTwSTiHUPQzTJlHbTbzrpGF3h1vVBww=;
        b=wjwMM2KWT8HU0SHDHdNRxn0t00ajJ3rnXd0KHF3IvjHCM9C9HEucQqbNqO3DdnlESa
         nz4NidPHfLZdlM97AQO2l5R9cvi5qOsP8Ijvq8FdyQ975MNIp/vKfJQp4Fn/KRaq6Jwk
         4kloVUH4EDmpWV0M/Jbjnxx6ZpxxBUBTWBZfCkK7wrUfN/3hE3YtfIlsy05XGvIcQMBR
         YwOaTVtyj5jc9ti6xzcRvjvMofBrcZ2GDu27qgywzvVHzJ4o32YZtNXzHqvcANqA6/YW
         sTLo8o8faSsSn6oqDWZE2/b1jMu9Jj3r8qqQ2mBwBCqkSpgBEgjiP8UrfNG7IjOkrlZB
         RMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690842546; x=1691447346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q8GvYD+4dtlsTwSTiHUPQzTJlHbTbzrpGF3h1vVBww=;
        b=dFYn89qTO3FK0E+rvFKyTh2N/Ap9CXWv+67+sqY7YHHDdzwQX6NblG998ZrvO3ceKe
         MDQ3dl2jo3Py6edAJFfD/hNQs4my/BpH08tO6KnmOTJOPnDnrqKSjsLBp0mNU/NPYEIO
         XfWpMyCR3Z54BAWJt3BMmzIgcP0iTH9OZbvcgdnqWDP/nJ8iOklrQ1sU8SQL5G4Nlsrx
         PirUYkj5yaksnfjCn64NJeLO/azLfWVQOboUXaR3KR2PichU4nK/r5zqE563xTQr3peK
         L42wTAp9BBH4Iwg2BanGXVNr3qpPqHD65PrRBEysrpq+H4Y7P+MGZKGRY2l4VitecO2B
         X8cA==
X-Gm-Message-State: ABy/qLa53pZmEz3rSm+pqw9MP4xap9wsuyL4xya3CkwXJrkD0wWpoeDf
        5QiFsv4kxb4WTzG49EL8rh8mVJb/a6w=
X-Google-Smtp-Source: APBJJlGgIomNHDqU6KhEMJb1Ck8ilBU2ctVZYZehyK88j/kbenJFHvBGJ75gfwK64a/yrr50dO0Jiu4+k6c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b109:0:b0:56d:502:9eb0 with SMTP id
 p9-20020a81b109000000b0056d05029eb0mr90305ywh.6.1690842545957; Mon, 31 Jul
 2023 15:29:05 -0700 (PDT)
Date:   Mon, 31 Jul 2023 15:29:04 -0700
In-Reply-To: <20230731063317.3720-1-xin3.li@intel.com>
Mime-Version: 1.0
References: <20230731063317.3720-1-xin3.li@intel.com>
Message-ID: <ZMg1sD7IamB0INVs@google.com>
Subject: Re: [PATCH v9 00/36] x86: enable FRED for x86-64
From:   Sean Christopherson <seanjc@google.com>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Jim Mattson <jmattson@google.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Breno Leitao <leitao@debian.org>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ze Gao <zegao2021@gmail.com>, Fei Li <fei1.li@intel.com>,
        Conghui <conghui.chen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Jane Malalane <jane.malalane@citrix.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Yantengsi <siyanteng@loongson.cn>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Jul 30, 2023, Xin Li wrote:
> This patch set enables the Intel flexible return and event delivery
> (FRED) architecture for x86-64.

...

> -- 
> 2.34.1

What is this based on?	FYI, you're using a version of git that will (mostly)
automatically generate the based, e.g. I do 

  git format-patch --base=HEAD~$nr ...

in my scripts, where $nr is the number of patches I am sending.  My specific
approaches requires HEAD-$nr to be a publicly visible object/commit, but that
should be the case the vast majority of the time anyways.
